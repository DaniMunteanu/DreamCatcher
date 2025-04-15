extends RoomEnemies

@onready var drop_res = preload("res://MobDrop.tscn")

func _ready() -> void:
	enemies_count = 2
	Global.enemy_dead.connect(_on_enemy_dead)

func _on_enemy_dead(enemy_death_position: Vector2):
	enemies_count -= 1
	if enemies_count == 0:
		print("Au disparut inamicii")
		enemies_defeated.emit()
		queue_free()
