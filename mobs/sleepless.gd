class_name Enemy

extends CharacterBody2D

signal enemy_dead(enemy_death_position: Vector2)

func _ready() -> void:
	get_node("Health").max_health = 3
	get_node("Health").current_health = 3

func _on_health_health_depleted() -> void:
	enemy_dead.emit(global_position)
	queue_free()
	
func _on_hitbox_area_entered(hurtbox: Hurtbox):
	if hurtbox != null:
		hurtbox.take_damage(get_node("Hitbox").damage)
