extends TextureButton

func _on_pressed() -> void:
	BackgroundMusic.play_audio(BackgroundMusic.floor_audio)
	Global.close_shop.emit()
