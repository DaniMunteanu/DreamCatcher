extends Node2D

@onready var animation_player = $PlayerAnimation

func play_idle_left_animation():
	animation_player.play("PlayerIdleLeft")
	
func play_idle_right_animation():
	animation_player.play("PlayerIdleRight")
	
func play_idle_up_animation():
	animation_player.play("PlayerIdleUp")
	
func play_idle_down_animation():
	animation_player.play("PlayerIdleDown")
	
func play_walking_right_animation():
	animation_player.play("PlayerWalkingRight")
	
func play_walking_left_animation():
	animation_player.play("PlayerWalkingLeft")
	
func play_walking_down_animation():
	animation_player.play("PlayerWalkingDown")
	
func play_walking_up_animation():
	animation_player.play("PlayerWalkingUp")
	
func play_firing_right_animation():
	animation_player.play("PlayerFiringRight")
	
func play_firing_left_animation():
	animation_player.play("PlayerFiringLeft")
	
func play_firing_down_animation():
	animation_player.play("PlayerFiringDown")
	
func play_firing_up_animation():
	animation_player.play("PlayerFiringUp")
	
func play_jumping_right_animation():
	animation_player.play("PlayerJumpingRight")
	
func play_jumping_left_animation():
	animation_player.play("PlayerJumpingLeft")
	
func play_reset_animation():
	animation_player.play("RESET")
