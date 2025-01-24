extends CharacterBody2D

@export var speed = 200.0

@onready var animation_player = $PlayerAnimationManager
@onready var sprite = $PlayerAnimationManager/PlayerModel
@onready var weapon = $TestWeapon

enum player_states {MOVE, JUMP}
var current_state = player_states.MOVE

func update_movement():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	
func update_sprite():
		
	if Input.is_action_just_pressed("evade") :
		current_state = player_states.JUMP
		
	if Input.is_action_pressed("fire"):
		var firing_angle = rad_to_deg(global_position.angle_to_point(get_global_mouse_position()))
		if firing_angle < 0:
			firing_angle += 360
		Global.cursor_angle = firing_angle
		print(Global.cursor_angle)
		if Global.cursor_angle <= 315:
			if Global.cursor_angle > 225:
				#weapon.current_fire_direction = weapon.fire_direction.UP
				weapon.sprite.flip_h = true
				weapon.animation_player.play_fire_down_animation()
				animation_player.play_firing_up_animation()
			elif Global.cursor_angle > 135:
				#weapon.current_fire_direction = weapon.fire_direction.LEFT
				weapon.sprite.flip_h = true
				weapon.animation_player.play_fire_right_animation()
				animation_player.play_firing_left_animation()
			elif Global.cursor_angle > 45:
				#weapon.current_fire_direction = weapon.fire_direction.DOWN
				weapon.sprite.flip_h = false
				weapon.animation_player.play_fire_down_animation()
				animation_player.play_firing_down_animation()
			else:
				#weapon.current_fire_direction = weapon.fire_direction.RIGHT
				weapon.sprite.flip_h = false
				weapon.animation_player.play_fire_right_animation()
				animation_player.play_firing_right_animation()
		else:
			#weapon.current_fire_direction = weapon.fire_direction.RIGHT
			weapon.sprite.flip_h = false
			weapon.animation_player.play_fire_right_animation()
			animation_player.play_firing_right_animation()
	else:
		if velocity.length() > 0.0:
			var walking_angle = rad_to_deg(velocity.angle())
			if walking_angle < 0:
				walking_angle += 360
			print(walking_angle)
			var angl = floor(walking_angle/45)
			match angl:
				5, 6:
					print("merge sus")
					animation_player.play_walking_up_animation()
				3, 4:
					print("merge stanga")
					animation_player.play_walking_left_animation()
				1, 2:
					print("merge jos")
					animation_player.play_walking_down_animation()
				0, 7:
					print("merge dreapta")
					animation_player.play_walking_right_animation()
			"""
			if Input.is_action_pressed("move_down"):
				animation_player.play_walking_down_animation()
			elif Input.is_action_pressed("move_up"):
				animation_player.play_walking_up_animation()
			else:
				animation_player.play_walking_right_animation()
			"""
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
	
