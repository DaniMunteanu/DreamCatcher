extends RoomEnemies

func _ready() -> void:
	enemies_count = 2
	for enemy in get_tree().get_nodes_in_group("Enemies"):
		enemy.connect("enemy_dead",_on_enemy_dead)

func _on_enemy_dead(enemy_death_position: Vector2):
	enemies_count -= 1
	if enemies_count == 0:
		print("Au disparut inamicii")
		enemies_defeated.emit()
		queue_free()
