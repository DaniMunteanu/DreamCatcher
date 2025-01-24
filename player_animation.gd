extends Node2D

func play_idle_right_animation():
	get_node("PlayerAnimation").play("PlayerIdleRight")
	
func play_walking_right_animation():
	get_node("PlayerAnimation").play("PlayerWalkingRight")
	
func play_walking_left_animation():
	get_node("PlayerAnimation").play("PlayerWalkingLeft")
	
func play_walking_down_animation():
	get_node("PlayerAnimation").play("PlayerWalkingDown")
	
func play_walking_up_animation():
	get_node("PlayerAnimation").play("PlayerWalkingUp")
	
func play_firing_right_animation():
	get_node("PlayerAnimation").play("PlayerFiringRight")
	
func play_firing_left_animation():
	get_node("PlayerAnimation").play("PlayerFiringLeft")
	
func play_firing_down_animation():
	get_node("PlayerAnimation").play("PlayerFiringDown")
	
func play_firing_up_animation():
	get_node("PlayerAnimation").play("PlayerWalkingUp")
	
func play_jumping_right_animation():
	get_node("PlayerAnimation").play("PlayerJumpingRight")
	
func play_jumping_left_animation():
	get_node("PlayerAnimation").play("PlayerJumpingLeft")
	
func play_reset_animation():
	get_node("PlayerAnimation").play("RESET")
