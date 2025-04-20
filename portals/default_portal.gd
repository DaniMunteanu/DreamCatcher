extends Area2D

const BULLET = preload("res://projectiles/projectile.tscn")

@onready var animation_player = $PortalAnimationPlayer

var fire_rate = 1.0
var fire_timer

func fire(delta):
	if fire_timer < fire_rate:
		fire_timer += delta
	
	if fire_timer >= fire_rate:
		shoot()
		fire_timer = 0.0

func shoot():
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.look_at(get_global_mouse_position())
	new_bullet.direction = global_position.direction_to(get_global_mouse_position()).normalized()
	get_parent().add_child(new_bullet)
