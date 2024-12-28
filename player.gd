extends CharacterBody2D

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 500
	move_and_slide()
	
	#"idle" is not really idle. Right now it is used for movement
	#The actual idle animation is the default "RESET" animation
	if velocity.length() > 0.0:
		get_node("PlayerTestVisual").play_idle_animation()
	else:
		get_node("PlayerTestVisual").play_reset_animation()
		
	
		
	
