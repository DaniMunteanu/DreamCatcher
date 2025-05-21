extends Control

@onready var animation_player = get_node("AspectRatioContainer/Screen/AnimationPlayer")

func _ready() -> void:
	animation_player.play("MainMenu")
