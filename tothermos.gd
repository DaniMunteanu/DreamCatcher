extends StaticBody2D

@onready var BULLET = preload("res://BossBullet.tscn")
@onready var cooldown_timer = $AttackCooldownTimer
@onready var player = get_parent().get_parent().get_node("Player")

var bullets_start = []
var bullets_end = []

var bullet_lines = []

enum boss_attacks {BULLETS_HALF, BULLETS_MINUS_ONE}

func init_bullets_start():
	bullets_start.resize(32)
	for i in 32:
		bullets_start[i] = get_node("BulletPointsStart/ShootPointStart" + str(i))
		
func init_bullets_end():
	bullets_end.resize(32)
	for i in 32:
		bullets_end[i] = get_node("BulletPointsEnd/ShootPointEnd" + str(i))
		
func init_bullet_lines():
	bullet_lines.resize(32)
	for i in 32:
		bullet_lines[i] = get_node("BulletShootLines/Line" + str(i))
		
func attack():
	for i in 32:
		var new_bullet = BULLET.instantiate()
		new_bullet.position = bullets_start[i].position
		new_bullet.direction = bullets_start[i].position.direction_to(bullets_end[i].position)
		new_bullet.end_point = bullets_end[i].position
		add_child(new_bullet)
	cooldown_timer.start(3)

func show_attack_indicators():
	$AttackIndicatorsAnimations.play("BulletsIndication")
	
func prepare_bullets_minus_one():
	var firing_angle = rad_to_deg(global_position.angle_to_point(player.global_position))
	if firing_angle < 0.0:
		firing_angle += 360.0
	print(firing_angle)

func _ready() -> void:
	init_bullets_start()
	init_bullets_end()
	init_bullet_lines()
	cooldown_timer.start(3)

func _on_attack_cooldown_timer_timeout() -> void:
	show_attack_indicators()
