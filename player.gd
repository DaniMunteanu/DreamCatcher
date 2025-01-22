extends CharacterBody2D

@export var speed = 200.0

@onready var animation_player = $PlayerAnimationManager
@onready var sprite = $PlayerAnimationManager/PlayerModel

func update_movement():
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	
func update_sprite():
	var horizontal_direction = Input.get_axis("move_left","move_right")
	if horizontal_direction != 0 :
		sprite.flip_h = (horizontal_direction == -1)
	
	if velocity.length() > 0.0:
		animation_player.play_walking_right_animation()
	else:
		if Input.is_action_pressed("shoot") :
			animation_player.play_firing_right_animation()
		else: 
			animation_player.play_idle_right_animation()
	
	
	
func _physics_process(delta):
	update_movement()
	update_sprite()
	
