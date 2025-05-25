extends TextureProgressBar

@onready var health: Health = get_parent().character.get_node("PlayerHealth")

func _ready() -> void:
	Global.buy_health_hover.connect(_on_buy_health_hover)
	Global.buy_health_hover_end.connect(_on_buy_health_hover_end)
	max_value = health.max_health
	value = health.current_health
	get_node("SecondaryHealthBar").value = health.current_health
	get_node("HealthAmount").text = str(value) + "/" + str(max_value)
	health.health_changed.connect(_update_bar)
	health.health_depleted.connect(_on_health_depleted)
	
func _update_bar(diff: int):
	value = health.current_health
	get_node("HealthAmount").text = str(value) + "/" + str(max_value)
	
	await get_tree().create_timer(0.5).timeout
	get_node("SecondaryHealthBar").value = health.current_health
	
func _on_health_depleted():
	get_parent().get_node("AnimationPlayer").play("HealthDepleted")
	get_parent().character.set_to_dead()
	
func send_game_over_signal():
	Global.game_over.emit()
	
func _on_buy_health_hover(health_to_buy: int):
	get_node("SecondaryHealthBar").value = clampi(value + health_to_buy,0,max_value)
	get_node("HealthAmount").text = str(get_node("SecondaryHealthBar").value) + "/" + str(max_value)
	get_node("HealthAmount").set("theme_override_colors/font_color",Color(0.792, 0.4, 0.259)) 

func _on_buy_health_hover_end():
	get_node("SecondaryHealthBar").value = health.current_health
	get_node("HealthAmount").text = str(value) + "/" + str(max_value)
	get_node("HealthAmount").set("theme_override_colors/font_color",Color(1, 1, 1))
	
