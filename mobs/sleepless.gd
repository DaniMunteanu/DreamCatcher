extends CharacterBody2D

signal enemy_dead

func _on_health_health_depleted() -> void:
	enemy_dead.emit()
	queue_free()
