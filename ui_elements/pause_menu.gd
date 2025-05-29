extends Control

var can_open_menu = false
var game_started = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause") && game_started && can_open_menu: 
		if get_tree().paused == false:
			Global.pause_game.emit()
			show()
		else:
			hide()
			Global.unpause_game.emit()

func _on_resume_game_button_pressed() -> void:
	hide()
	Global.unpause_game.emit()

func _on_exit_to_menu_button_pressed() -> void:
	game_started = false
	hide()
	TransitionScreen.transition_black()
	await TransitionScreen.on_transition_finished
	Global.save_game.emit()
	Global.open_main_menu.emit()
	TransitionScreen.ready_for_fade_out.emit()
