extends CharacterBody2D

#200
@export var speed = 200.0

@onready var animation_player = $PlayerAnimationManager
@onready var sprite = $PlayerAnimationManager/PlayerModel
@onready var weapon = $TestWeapon

enum player_states {MOVE, JUMP, FIRE}
var current_state = player_states.MOVE

var jumping_direction = Vector2.ZERO
var jumping_target_position = Vector2.ZERO

var jumping_distance = 96.0

func update_movement():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	
func update_sprite():
	if Input.is_action_pressed("evade") :
		jumping_target_position = global_position.move_toward(get_global_mouse_position(), jumping_distance)
		jumping_direction = global_position.direction_to(jumping_target_position).normalized()
	
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
			3.0, 4.0:
				animation_player.play_walking_left_animation()
			1.0, 2.0:
				animation_player.play_walking_down_animation()
			0.0, 7.0:
				animation_player.play_walking_right_animation()
	else:
		animation_player.play_idle_right_animation()

func jump(delta):
	animation_player.play_jumping_right_animation()
	
	if global_position.distance_to(jumping_target_position) > 3:
		global_position += global_position.direction_to(jumping_target_position) * speed * delta
	
func fire(delta):
	if Input.is_action_pressed("evade") :
		jumping_target_position = global_position.move_toward(get_global_mouse_position(), jumping_distance)
		jumping_direction = global_position.direction_to(jumping_target_position).normalized()
		
		current_state = player_states.JUMP
	
	weapon.fire(delta)
	
	var firing_angle = rad_to_deg(global_position.angle_to_point(get_global_mouse_position()))
	if firing_angle < 0.0:
		firing_angle += 360.0
	Global.cursor_angle = firing_angle
		
	match floor(Global.cursor_angle/45.0):
		5.0, 6.0:
			weapon.animation_player.play_fire_up_animation()
			animation_player.play_firing_up_animation()
		3.0, 4.0:
			weapon.animation_player.play_fire_left_animation()
			animation_player.play_firing_left_animation()
		1.0, 2.0:
			weapon.animation_player.play_fire_down_animation()
			animation_player.play_firing_down_animation()
		0.0, 7.0:
			weapon.animation_player.play_fire_right_animation()
			animation_player.play_firing_right_animation()
			
	if Input.is_action_just_released("fire"):
		weapon.fire_timer = 0.5
		on_states_reset()
		
func on_states_reset():
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
	
