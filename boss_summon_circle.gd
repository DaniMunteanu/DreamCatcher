extends Node2D

@onready var player = get_parent().get_parent().get_node("Player")

signal summoning_complete

func _ready() -> void:
	$InteractionArea.interact = Callable(self, "summon_boss")
	
func summon_boss():
	$InteractionArea.can_interact = false
	TransitionScreen.transition()
	player.set_to_cutscene()
	await TransitionScreen.on_transition_finished
	player.global_position = $PlayerEndPosition.global_position
	player.get_node("PlayerCamera").global_position = $CameraCutscenePosition.global_position
	$AnimationPlayer.play("Summon")
	
func on_cutscene_finished():
	player.get_node("PlayerCamera").global_position = player.global_position
	player.on_states_reset()
	player.jump_marker.visible = true
	summoning_complete.emit()
	queue_free()
