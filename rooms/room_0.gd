extends FloorRoom

@onready var boss = preload("res://Tothermos.tscn")

var movable_walls = []

func initialize_movable_walls():
	movable_walls.resize(18)
	for i in 18:
		movable_walls[i] = get_node("RisingWalls/RisingWall" + str(i))

func _ready() -> void:
	initialize_movable_walls()

func _init():
	room_index = 0
	available_rooms = [1,2,3,4,5,6]
	potential_doors = [0,1,2,3,4,5,6,7,8,9]
	can_extend = true

func reset_room():
	super()
	available_rooms = [1,2,3,4,5,6]

func _on_boss_summon_circle_summoning_complete() -> void:
	var boss_instance = boss.instantiate()
	boss_instance.global_position = $BossSpawnPoint.position
	add_child(boss_instance)
	Global.boss_summoned.emit()

func _on_boss_summon_circle_raise_walls() -> void:
	for i in 18:
		movable_walls[i].get_node("AnimationPlayer").play("Raise")
