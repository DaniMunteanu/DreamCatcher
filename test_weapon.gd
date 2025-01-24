extends Area2D

const BULLET = preload("res://projectile.tscn")

@onready var animation_player = $WeaponAnimationPlayer
@onready var sprite = $TestWeapon

enum fire_direction {LEFT, RIGHT, UP, DOWN}
var current_fire_direction = fire_direction.LEFT

var fire_rate = 1.0
var fire_timer : float

func _ready():
	visible = false

func _physics_process(delta):
	if fire_timer < fire_rate:
		fire_timer += delta
	
	if Input.is_action_pressed("fire") && fire_timer >= fire_rate:
		visible = true
		fire()
		fire_timer = 0
		
	if Input.is_action_just_released("fire"):
		visible = false

func fire():
	
	#var firing_angle = Global.cursor_angle
	
	"
	match(current_fire_direction):
		fire_direction.LEFT:
			sprite.flip_h = true
			animation_player.play_fire_right_animation()
		fire_direction.RIGHT:
			sprite.flip_h = false
			animation_player.play_fire_right_animation()
		fire_direction.UP:
			sprite.flip_h = true
			animation_player.play_fire_down_animation()
		fire_direction.DOWN:
			sprite.flip_h = false
			animation_player.play_fire_down_animation()
	"
	
	"""
	if Global.cursor_angle <= 315:
		if Global.cursor_angle > 225:
			sprite.flip_h = true
			animation_player.play_fire_down_animation()
		elif Global.cursor_angle > 135:
			sprite.flip_h = true
			animation_player.play_fire_right_animation()
		elif Global.cursor_angle > 45:
			sprite.flip_h = false
			animation_player.play_fire_down_animation()
		else:
			sprite.flip_h = false
			animation_player.play_fire_right_animation()
	else:
		sprite.flip_h = false
		animation_player.play_fire_right_animation()
	"""
	
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
