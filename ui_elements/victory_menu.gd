extends Control

@onready var animation_player = get_node("AspectRatioContainer/Screen/AnimationPlayer")

func _ready() -> void:
	animation_player.play("FallingLoop")

func _on_start_new_game_button_pressed() -> void:
	Global.create_new_game.emit()

func _on_exit_to_main_menu_button_pressed() -> void:
	animation_player.play("FallingToMainMenu")

func open_main_menu():
	Global.open_main_menu.emit()
	queue_free()
