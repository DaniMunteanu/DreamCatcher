extends TextureButton

@onready var health: Health = get_parent().character.get_node("Health")

func _ready() -> void:
	Global.check_funds.connect(_on_check_funds)

func _on_check_funds():
	if Global.player_coins < 50:
		get_parent().get_node("CoinAmmountForHealth").set("theme_override_colors/font_color",Color(1, 0, 0))
		disabled = true
	else:
		get_parent().get_node("CoinAmmountForHealth").set("theme_override_colors/font_color",Color(1, 1, 1))
		disabled = false
	
	if health.current_health == health.max_health:
		disabled = true

func _on_mouse_entered() -> void:
	Global.buy_health_hover.emit(15)
	
func _on_mouse_exited() -> void:
	Global.buy_health_hover_end.emit()
	
func _on_pressed() -> void:
	Global.health_bought.emit(15)
	Global.loot_spent.emit(Global.loot_types.COIN, 50)
	Global.check_funds.emit()
