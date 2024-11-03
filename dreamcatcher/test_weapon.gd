extends Area2D

const BULLET = preload("res://projectile.tscn")

var fire_rate = 1.0
var fire_timer : float

func _ready():
	visible = false

func _physics_process(delta):
	look_at(get_global_mouse_position())
	if fire_timer < fire_rate:
		fire_timer += delta
	
	if Input.is_action_pressed("shoot") && fire_timer >= fire_rate:
		visible = true
		shoot()
		fire_timer = 0
		
	if Input.is_action_just_released("shoot"):
		visible = false

func shoot():
	var new_left_bullet = BULLET.instantiate()
	new_left_bullet.global_position = %LeftShootingPoint.global_position
	new_left_bullet.global_rotation = %LeftShootingPoint.global_rotation
	new_left_bullet.mouse_location = (global_position - get_global_mouse_position()).normalized()
	%LeftShootingPoint.add_child(new_left_bullet)
	
	await get_tree().create_timer(0.5).timeout
	
	var new_right_bullet = BULLET.instantiate()
	new_right_bullet.global_position = %RightShootingPoint.global_position
	new_right_bullet.global_rotation = %RightShootingPoint.global_rotation
	new_right_bullet.mouse_location = (global_position - get_global_mouse_position()).normalized()
	%RightShootingPoint.add_child(new_right_bullet)
