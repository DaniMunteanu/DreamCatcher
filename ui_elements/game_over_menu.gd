extends Control

@onready var animation_player = get_node("AspectRatioContainer/Screen/AnimationPlayer")
@onready var title_animation_player = get_node("AspectRatioContainer/Screen/TitleAnimationPlayer")

@onready var start_new_game_button = get_node("AspectRatioContainer/Screen/StartNewGameButton")
@onready var exit_to_main_menu_button = get_node("AspectRatioContainer/Screen/ExitToMainMenuButton")

func _ready() -> void:
	start_new_game_button.disabled = true
	exit_to_main_menu_button.disabled = true
	
	start_new_game_button.visible = false
	exit_to_main_menu_button.visible = false
	
	animation_player.play("FallingAsleep")
	BackgroundMusic.play_audio(BackgroundMusic.game_over_audio)

func _on_start_new_game_button_pressed() -> void:
	Global.create_new_game.emit()

func _on_exit_to_main_menu_button_pressed() -> void:
	TransitionScreen.transition_black()
	await TransitionScreen.on_transition_finished
	Global.open_main_menu.emit()
	TransitionScreen.ready_for_fade_out.emit()
	queue_free()

func start_sleep_loop():
	animation_player.play("Sleeping")
	title_animation_player.play("TitleFloat")
	
	start_new_game_button.disabled = false
	exit_to_main_menu_button.disabled = false
	
	start_new_game_button.visible = true
	exit_to_main_menu_button.visible = true
