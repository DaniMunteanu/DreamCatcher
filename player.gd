class_name Player

extends CharacterBody2D

var speed_multiplier = 30.0

@onready var animation_player = $PlayerAnimationManager
@onready var sprite = $PlayerAnimationManager/PlayerModel
@onready var portal1 = $Portal1
@onready var portal2 = $Portal2
@onready var canvas_layer = $PlayerCamera/CanvasLayer

@onready var jump_marker = $JumpMarker
@onready var evade_timer = $EvadeTimer
var evadeReady = true
var jump_speed = 200.0

const SHOP = preload("res://ui_elements/Shop.tscn")
@onready var opened_shop = SHOP.instantiate()

enum player_states {MOVE, JUMP, FIRE, SHOP}
var current_state = player_states.MOVE

enum player_direction {LEFT, RIGHT, UP, DOWN}
var current_player_direction = player_direction.RIGHT

var jumping_direction = Vector2.ZERO
var jumping_target_position = Vector2.ZERO

var jumping_distance = 96.0

func _on_health_health_depleted() -> void:
	pass

func _ready() -> void:
	Global.open_shop.connect(_on_open_shop)
	Global.close_shop.connect(_on_close_shop)
	opened_shop.character = self
	portal1.fire_timer = (2.0 - (0.2 * Global.player_fire_rate)) / 2.0 
	portal2.fire_timer = 0.0
	
func _on_open_shop():
	canvas_layer.add_child(opened_shop)
	opened_shop.update()
	current_state = player_states.SHOP
	
func _on_close_shop():
	canvas_layer.remove_child(opened_shop)
	current_state = player_states.MOVE
	
func _on_evade_timer_timeout() -> void:
	evadeReady = true
	get_node("JumpMarker").visible = true

func update_movement():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = direction.normalized()
	velocity = direction * (speed_multiplier * Global.player_speed)
	move_and_slide()
	Global.player_current_position = global_position
	
func update_sprite():
	if Input.is_action_pressed("evade") and evadeReady:
		jumping_target_position = global_position.move_toward(get_global_mouse_position(), jumping_distance)
		jumping_direction = global_position.direction_to(jumping_target_position).normalized()
	
		set_collision_layer_value(2,false)
		evadeReady = false
		evade_timer.start()
		current_state = player_states.JUMP
		
	if Input.is_action_pressed("fire"):
		current_state = player_states.FIRE
	
	if velocity.length() > 0.0:
		var walking_angle = rad_to_deg(velocity.angle())
		if walking_angle < 0:
			walking_angle += 360
		match floor(walking_angle/45.0):
			5.0, 6.0:
				animation_player.play_walking_up_animation()
				current_player_direction = player_direction.UP
			3.0, 4.0:
				animation_player.play_walking_left_animation()
				current_player_direction = player_direction.LEFT
			1.0, 2.0:
				animation_player.play_walking_down_animation()
				current_player_direction = player_direction.DOWN
			0.0, 7.0:
				animation_player.play_walking_right_animation()
				current_player_direction = player_direction.RIGHT
	else:
		match current_player_direction:
			player_direction.UP:
				animation_player.play_idle_up_animation()
			player_direction.LEFT:
				animation_player.play_idle_left_animation()
			player_direction.DOWN:
				animation_player.play_idle_down_animation()
			player_direction.RIGHT:
				animation_player.play_idle_right_animation()

func jump(delta):
	jump_marker.visible = false
	animation_player.play_jumping_right_animation()
	if global_position.distance_to(jumping_target_position) > 3:
		velocity = global_position.direction_to(jumping_target_position) * jump_speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
func fire(delta):
	if Input.is_action_pressed("evade") :
		jumping_target_position = global_position.move_toward(get_global_mouse_position(), jumping_distance)
		jumping_direction = global_position.direction_to(jumping_target_position).normalized()
		
		set_collision_layer_value(2,false)
		evadeReady = false
		evade_timer.start()
		current_state = player_states.JUMP
	
	portal1.fire(delta)
	portal2.fire(delta)
	
	var firing_angle = rad_to_deg(global_position.angle_to_point(get_global_mouse_position()))
	if firing_angle < 0.0:
		firing_angle += 360.0
	Global.cursor_angle = firing_angle
		
	match floor(Global.cursor_angle/45.0):
		5.0, 6.0:
			portal1.animation_player.play("ShootUp")
			portal2.animation_player.play("ShootUp")
			animation_player.play_firing_up_animation()
		3.0, 4.0:
			portal1.animation_player.play("Portal1ShootLeft")
			portal2.animation_player.play("Portal2ShootLeft")
			animation_player.play_firing_left_animation()
		1.0, 2.0:
			portal1.animation_player.play("ShootDown")
			portal2.animation_player.play("ShootDown")
			animation_player.play_firing_down_animation()
		0.0, 7.0:
			portal1.animation_player.play("Portal1ShootRight")
			portal2.animation_player.play("Portal2ShootRight")
			animation_player.play_firing_right_animation()
			
	if Input.is_action_just_released("fire"):
		portal1.fire_timer = (2.0 - (0.2 * Global.player_fire_rate)) / 2.0 
		portal2.fire_timer = 0.0
		on_states_reset()
		
func on_states_reset():
	set_collision_layer_value(2,true)
	current_state = player_states.MOVE

func _physics_process(delta):
	match current_state:
		player_states.MOVE:
			update_movement()
			update_sprite()
			get_node("JumpMarkerAnimation").play("JumpReady")
		player_states.JUMP: 
			jump(delta)
		player_states.FIRE:
			update_movement()
			fire(delta)
			get_node("JumpMarkerAnimation").play("JumpReady")
