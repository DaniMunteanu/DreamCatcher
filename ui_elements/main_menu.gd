extends Control

@onready var animation_player = get_node("AspectRatioContainer/Cutscenes/AnimationPlayer")

func _ready() -> void:
	animation_player.play("MainMenu")
