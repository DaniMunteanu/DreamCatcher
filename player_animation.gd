extends Node2D

func play_idle_right_animation():
	get_node("PlayerAnimation").play("PlayerIdleRight")
	
func play_walking_right_animation():
	get_node("PlayerAnimation").play("PlayerWalkingRight")
	
func play_firing_right_animation():
	get_node("PlayerAnimation").play("PlayerFiringRight")
	
func play_reset_animation():
	get_node("PlayerAnimation").play("RESET")
