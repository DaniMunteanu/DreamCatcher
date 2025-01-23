extends CharacterBody2D

@export var speed = 200.0

@onready var animation_player = $PlayerAnimationManager
@onready var sprite = $PlayerAnimationManager/PlayerModel

enum player_states {MOVE, JUMP}
var current_state = player_states.MOVE

func update_movement():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	
func update_sprite():
	var horizontal_direction = Input.get_axis("move_left","move_right")
	if horizontal_direction != 0 :
		sprite.flip_h = (horizontal_direction == -1)
		
	if Input.is_action_just_pressed("evade") :
		current_state = player_states.JUMP
		
	if Input.is_action_pressed("fire"):
		var firing_angle = rad_to_deg(global_position.angle_to_point(get_global_mouse_position()))
		if firing_angle < 0:
			firing_angle += 360
		print(firing_angle)
		if firing_angle <= 315:
			if firing_angle > 225:
				sprite.flip_h = false
				animation_player.play_firing_up_animation()
			elif firing_angle > 135:
				sprite.flip_h = true
				animation_player.play_firing_right_animation()
			elif firing_angle > 45:
				sprite.flip_h = false
				animation_player.play_firing_down_animation()
			else:
				sprite.flip_h = false
				animation_player.play_firing_right_animation()
		else:
			sprite.flip_h = false
			animation_player.play_firing_right_animation()
	else:
		if velocity.length() > 0.0:
			if Input.is_action_pressed("move_down"):
				animation_player.play_walking_down_animation()
			elif Input.is_action_pressed("move_up"):
				animation_player.play_walking_up_animation()
			else:
				animation_player.play_walking_right_animation()
		else:
			animation_player.play_idle_right_animation()
	

func jump():
	animation_player.play_jumping_right_animation()
		
func on_states_reset():
	current_state = player_states.MOVE

func _physics_process(delta):
	match current_state:
		player_states.MOVE:
			update_movement()
			update_sprite()
		player_states.JUMP:
			jump()
	
