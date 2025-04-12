extends TextureProgressBar

@onready var health: Health = get_parent().character.get_node("Health")

func _ready() -> void:
	max_value = health.max_health
	value = health.current_health
	get_node("HealthAmount").text = str(value) + "/" + str(max_value)
	health.health_changed.connect(_update_bar)
	
func _update_bar(diff: int):
	value = health.current_health
	get_node("HealthAmount").text = str(value) + "/" + str(max_value)
	
func _on_buy_health_hover():
	pass

func _on_buy_health_hover_end():
	pass
	
