extends Control

@onready var animation_player = get_node("AspectRatioContainer/Screen/AnimationPlayer")
@onready var title_animation_player = get_node("AspectRatioContainer/Screen/TitleAnimationPlayer")
@onready var resume_game_button = get_node("AspectRatioContainer/Screen/ResumeGameButton")

func _ready() -> void:
	BackgroundMusic.play_audio(BackgroundMusic.main_menu_audio)
	animation_player.play("MainMenu")
	title_animation_player.play("TitleFloat")
	if FileAccess.file_exists("user://SavedFloor.tscn") == false:
		resume_game_button.disabled = true

func _on_exit_to_desktop_button_pressed() -> void:
	get_tree().quit()

func _on_resume_game_button_pressed() -> void:
	Global.load_saved_game.emit()
