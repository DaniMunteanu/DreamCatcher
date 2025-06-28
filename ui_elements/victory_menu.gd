extends Control

@onready var animation_player = get_node("AspectRatioContainer/Screen/AnimationPlayer")
@onready var title_animation_player = get_node("AspectRatioContainer/Screen/TitleAnimationPlayer")

@onready var start_new_game_button = get_node("AspectRatioContainer/Screen/StartNewGameButton")
@onready var exit_to_main_menu_button = get_node("AspectRatioContainer/Screen/ExitToMainMenuButton")
@onready var title_sprite = get_node("AspectRatioContainer/Screen/VictoryTitle")

func _ready() -> void:
	animation_player.play("FallingLoop")
	title_animation_player.play("TitleFloat")
	
	start_new_game_button.disabled = false
	exit_to_main_menu_button.disabled = false
	
	start_new_game_button.visible = true
	exit_to_main_menu_button.visible = true
	
	title_sprite.visible = true

func _on_start_new_game_button_pressed() -> void:
	Global.create_new_game.emit()

func _on_exit_to_main_menu_button_pressed() -> void:
	start_new_game_button.disabled = true
	exit_to_main_menu_button.disabled = true
	
	start_new_game_button.visible = false
	exit_to_main_menu_button.visible = false
	
	title_sprite.visible = false
	
	animation_player.play("FallingToMainMenu")
	BackgroundMusic.gradual_volume_down(1)
	
func open_main_menu():
	Global.open_main_menu.emit()
	queue_free()
