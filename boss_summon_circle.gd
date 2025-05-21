extends Node2D

@onready var player = get_parent().get_parent().get_node("Player")

signal summoning_complete
signal raise_walls

func _ready() -> void:
	$InteractionArea.interact = Callable(self, "summon_boss")
	
func summon_boss():
	$InteractionArea.can_interact = false
	TransitionScreen.transition_black()
	await TransitionScreen.on_transition_finished
	TransitionScreen.ready_for_fade_out.emit()
	player.set_to_cutscene()
	player.get_node("PlayerCamera").position_smoothing_enabled = true
	player.get_node("PlayerCamera").position_smoothing_speed = 2.0
	player.global_position = $PlayerEndPosition.global_position
	player.get_node("PlayerCamera").global_position = $CameraCutscenePosition.global_position
	$AnimationPlayer.play("Summon")
	
func send_raise_walls_signal():
	raise_walls.emit()

func on_cutscene_finished():
	player.get_node("PlayerCamera").global_position = player.global_position
	await get_tree().create_timer(0.5).timeout
	player.get_node("PlayerCamera").position_smoothing_enabled = false
	player.on_states_reset()
	player.jump_marker.visible = true
	summoning_complete.emit()
	queue_free()
