extends Node2D

func play_idle_animation():
	get_node("PlayerTestAnimation").play("Idle")
	
func play_reset_animation():
	get_node("PlayerTestAnimation").play("RESET")
