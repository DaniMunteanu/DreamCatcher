extends StaticBody2D

@onready var BULLET = preload("res://BossBullet.tscn")

var bullets_start = []
var bullets_end = []

var bullet_lines = []

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
		new_bullet.global_position = bullets_start[i].global_position
		new_bullet.direction = bullets_start[i].global_position.direction_to(bullets_end[i].global_position).normalized()
		new_bullet.end_point = bullets_end[i].position
		add_child(new_bullet)

func show_attack_indicators():
	$AttackIndicatorsAnimations.play("BulletsIndication")

func _ready() -> void:
	init_bullets_start()
	init_bullets_end()
	init_bullet_lines()
	show_attack_indicators()
