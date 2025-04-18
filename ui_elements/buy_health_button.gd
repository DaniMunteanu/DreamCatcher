extends TextureButton

func _ready() -> void:
	Global.check_funds.connect(_on_check_funds)

func _on_check_funds():
	if Global.player_coins < 50:
		disabled = true
	else:
		disabled = false

func _on_mouse_entered() -> void:
	Global.buy_health_hover.emit(15)
	
func _on_mouse_exited() -> void:
	Global.buy_health_hover_end.emit()
	
func _on_pressed() -> void:
	Global.health_bought.emit(15)
	Global.loot_spent.emit(Global.loot_types.COIN, 50)
	Global.check_funds.emit()
