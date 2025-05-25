extends Control

@onready var animation_player = get_node("AspectRatioContainer/Screen/AnimationPlayer")
@onready var title_animation_player = get_node("AspectRatioContainer/Screen/TitleAnimationPlayer")

func _ready() -> void:
	animation_player.play("MainMenu")
	title_animation_player.play("TitleFloat")

func _on_exit_to_desktop_button_pressed() -> void:
	get_tree().quit()
