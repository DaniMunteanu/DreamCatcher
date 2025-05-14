extends Health

func _ready() -> void:
	Global.health_bought.connect(_on_health_bought)
	
func _on_health_bought(health_to_buy: int):
	set_current_health(current_health + health_to_buy)
