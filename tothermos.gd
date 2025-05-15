extends StaticBody2D

@onready var BULLET = preload("res://BossBullet.tscn")
@onready var cooldown_timer = $AttackCooldownTimer
@onready var boss_animation_player = $BossAnimations
@onready var player = get_parent().get_parent().get_node("Player")

signal lower_walls
signal attack_over

var bullets_start = []
var bullets_end = []
var bullet_lines = []

var bullet_lines_angles = []

var initial_active_shooting_points = []
var active_shooting_points = []

var safe_spots_half = []
var safe_spots_minus_three = []
var attack_waves

enum boss_attacks {BULLETS_HALF, BULLETS_MINUS_THREE}
enum direction {CLOCKWISE, COUNTER_CLOCKWISE}

func init_variables():
	bullets_start.resize(32)
	bullets_end.resize(32)
	bullet_lines.resize(32)
	bullet_lines_angles.resize(32)
	initial_active_shooting_points.resize(32)
	safe_spots_half.resize(16)
	safe_spots_minus_three.resize(3)
	for i in 32:
		bullets_start[i] = get_node("BulletPointsStart/ShootPointStart" + str(i))
		bullets_end[i] = get_node("BulletPointsEnd/ShootPointEnd" + str(i))
		bullet_lines[i] = get_node("BulletShootLines/Line" + str(i))
		bullet_lines_angles[i] = rad_to_deg($BulletsCenterPoint.global_position.angle_to_point(bullets_end[i].global_position))
		if bullet_lines_angles[i] < 0.0:
			bullet_lines_angles[i] += 360.0
		initial_active_shooting_points[i] = i
		
func attack():
	for i in active_shooting_points:
		var new_bullet = BULLET.instantiate()
		new_bullet.position = bullets_start[i].position
		new_bullet.direction = bullets_start[i].position.direction_to(bullets_end[i].position)
		new_bullet.end_point = bullets_end[i].position
		$Bullets.add_child(new_bullet)

func show_attack_indicators():
	$AttackIndicatorsAnimations.play("BulletsIndication")
	
func left_neighbour_index(index: int) -> int:
	if index == 0:
		return 31
	else:
		return index-1
		
func right_neighbour_index(index: int) -> int:
	if index == 31:
		return 0
	else:
		return index+1
	
func bullets_half():
	attack_waves = 2
	
	for i in attack_waves:
		for j in 16:
			safe_spots_half[j] = 2*j
		await begin_attack(safe_spots_half)
		
		for j in 16:
			safe_spots_half[j] = 2*j+1
		await begin_attack(safe_spots_half)
	
	attack_over.emit()

func bullets_minus_three():
	attack_waves = 5
	
	safe_spots_minus_three = [31,0,1]
	
	var firing_angle = rad_to_deg($BulletsCenterPoint.global_position.angle_to_point(player.global_position))
	if firing_angle < 0.0:
		firing_angle += 360.0
		
	for i in 32: 
		if firing_angle <= bullet_lines_angles[i]:
			safe_spots_minus_three[0] = left_neighbour_index(i)
			safe_spots_minus_three[1] = i
			safe_spots_minus_three[2] = right_neighbour_index(i)
			break
			
	for i in attack_waves:
		await begin_attack(safe_spots_minus_three)
	
		var rng = RandomNumberGenerator.new()
		var picked_direction = rng.randi_range(direction.CLOCKWISE,direction.COUNTER_CLOCKWISE)
		
		if picked_direction == direction.CLOCKWISE:
			safe_spots_minus_three[0] = right_neighbour_index(safe_spots_minus_three[2])
			safe_spots_minus_three[1] = right_neighbour_index(safe_spots_minus_three[0])
			safe_spots_minus_three[2] = right_neighbour_index(safe_spots_minus_three[1])
		else:
			safe_spots_minus_three[2] = left_neighbour_index(safe_spots_minus_three[0])
			safe_spots_minus_three[1] = left_neighbour_index(safe_spots_minus_three[2])
			safe_spots_minus_three[0] = left_neighbour_index(safe_spots_minus_three[1])
			
	attack_over.emit()
	
func begin_attack(safe_spots: Array):
	active_shooting_points = initial_active_shooting_points.duplicate(false)
	for spot in safe_spots:
		bullet_lines[spot].visible = false
		active_shooting_points.erase(spot)
	
	show_attack_indicators()
	
	await $AttackIndicatorsAnimations.animation_finished
	
	for spot in safe_spots:
		bullet_lines[spot].visible = true

func _ready() -> void:
	init_variables()
	cooldown_timer.start(5)

func _on_attack_cooldown_timer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	var picked_attack = rng.randi_range(boss_attacks.BULLETS_HALF,boss_attacks.BULLETS_MINUS_THREE)
	match picked_attack:
		boss_attacks.BULLETS_HALF:
			bullets_half()
		boss_attacks.BULLETS_MINUS_THREE:
			bullets_minus_three()
	await attack_over
	cooldown_timer.start(5)
	
func send_lower_walls_signal():
	lower_walls.emit()
	
func boss_death_cutscene_finished():
	TransitionScreen.transition_white()
	Global.boss_defeated.emit()
	queue_free()
	
func _on_health_health_depleted() -> void:
	cooldown_timer.stop()
	for bullet in $Bullets.get_children():
		bullet.queue_free()
	$AttackIndicatorsAnimations.stop()
	$BulletShootLines.visible = false
	player.set_to_cutscene()
	player.get_node("PlayerCamera").position_smoothing_enabled = true
	player.get_node("PlayerCamera").position_smoothing_speed = 2.0
	player.get_node("PlayerCamera").global_position = self.global_position
	boss_animation_player.play("Dead")
	lower_walls.emit()
