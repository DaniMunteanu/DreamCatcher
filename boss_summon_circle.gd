extends Node2D

@onready var player = get_parent().get_parent().get_node("Player")

func _ready() -> void:
	$InteractionArea.interact = Callable(self, "summon_boss")
	
func summon_boss():
	$InteractionArea.can_interact = false
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	player.global_position = $PlayerEndPosition.global_position
	$AnimationPlayer.play("Summon")
