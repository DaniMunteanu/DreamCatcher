class_name RoomEnemies

extends Node2D

@export var enemies_count: int

signal enemies_defeated

func _ready() -> void:
	enemies_count = get_child_count()
	Global.enemy_dead.connect(_on_enemy_dead)

func _on_enemy_dead(enemy_death_position: Vector2):
	enemies_count -= 1
	if enemies_count == 0:
		print("Au disparut inamicii")
		enemies_defeated.emit()
		queue_free()
