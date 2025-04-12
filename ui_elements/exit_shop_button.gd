extends TextureButton

func _on_pressed() -> void:
	Global.close_shop.emit()
