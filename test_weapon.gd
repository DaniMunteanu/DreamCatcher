extends Area2D

const BULLET = preload("res://projectiles/projectile.tscn")

@onready var animation_player = $WeaponAnimationPlayer
@onready var sprite = $TestWeapon

enum fire_direction {LEFT, RIGHT, UP, DOWN}
var current_fire_direction = fire_direction.LEFT

var fire_rate = 1.0
var fire_timer = 0.5

func fire(delta):
	if fire_timer < fire_rate:
		fire_timer += delta
	
	if fire_timer >= fire_rate:
		shoot()
		fire_timer = 0.0

func shoot():
	%LeftShootingPoint.look_at(get_global_mouse_position())
	
	var new_left_bullet = BULLET.instantiate()
	new_left_bullet.global_position = %LeftShootingPoint.global_position
	new_left_bullet.global_rotation = %LeftShootingPoint.global_rotation
	new_left_bullet.direction = global_position.direction_to(get_global_mouse_position()).normalized()
	%LeftShootingPoint.add_child(new_left_bullet)
	
	await get_tree().create_timer(0.5).timeout
	
	%RightShootingPoint.look_at(get_global_mouse_position())
	
	var new_right_bullet = BULLET.instantiate()
	new_right_bullet.global_position = %RightShootingPoint.global_position
	new_right_bullet.global_rotation = %RightShootingPoint.global_rotation
	new_right_bullet.direction = global_position.direction_to(get_global_mouse_position()).normalized()
	if Input.is_action_pressed("fire"):
		%RightShootingPoint.add_child(new_right_bullet)
