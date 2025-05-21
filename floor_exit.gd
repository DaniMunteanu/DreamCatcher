extends StaticBody2D

@onready var player = get_parent().get_parent().get_node("Player")

func _ready() -> void:
	$InteractionArea.interact = Callable(self, "exit_floor")
	
func exit_floor():
	$InteractionArea.can_interact = false
	TransitionScreen.transition_black()
	player.set_to_cutscene()
	player.visible = false
	await TransitionScreen.on_transition_finished
	player.get_node("PlayerCamera").global_position = global_position
	$FloorExitSprite.frame = 1
	TransitionScreen.ready_for_fade_out.emit()
	$AnimationPlayer.play("ExitCutscene")
