extends TextureButton

func _on_pressed() -> void:
	Global.create_new_game.emit()
	disabled = true
