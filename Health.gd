class_name Health

extends Node

signal health_changed(diff: int)
signal health_depleted

@export var max_health: int
@export var current_health: int

func _ready() -> void:
	Global.health_bought.connect(_on_health_bought)

func set_current_health(value: int):
	var clamped_value = clampi(value,0,max_health)
	
	if clamped_value != current_health:
		print("clamped value is ", clamped_value)
		print("current health is ",current_health)
		var diff = clamped_value - current_health
		current_health = clamped_value
		health_changed.emit(diff)
		
		if current_health == 0:
			health_depleted.emit()

func _on_hurtbox_received_damage(damage: int) -> void:
	set_current_health(current_health - damage)

func _on_health_bought(health_to_buy: int):
	set_current_health(current_health + health_to_buy)
