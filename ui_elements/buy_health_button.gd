extends TextureButton

func _on_mouse_entered() -> void:
	Global.buy_health_hover.emit(15)
	
func _on_mouse_exited() -> void:
	Global.buy_health_hover_end.emit()
