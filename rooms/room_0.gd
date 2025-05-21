extends FloorRoom

@onready var boss = preload("res://Tothermos.tscn")
@onready var floor_exit = preload("res://FloorExit.tscn")
@onready var player = get_parent().get_node("Player")

var movable_walls = []

func initialize_movable_walls():
	movable_walls.resize(18)
	for i in 18:
		movable_walls[i] = get_node("RisingWalls/RisingWall" + str(i))

func _ready() -> void:
	initialize_movable_walls()
	Global.boss_defeated.connect(_on_boss_defeated)

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
	boss_instance.lower_walls.connect(_on_tothermos_lower_walls)
	Global.boss_summoned.emit()
	
func _on_boss_defeated() -> void:
	await TransitionScreen.on_transition_finished
	var floor_exit_instance = floor_exit.instantiate()
	floor_exit_instance.global_position = $BossSpawnPoint.position
	add_child(floor_exit_instance)
	TransitionScreen.ready_for_fade_out.emit()
	player.get_node("PlayerCamera").global_position = player.global_position
	await get_tree().create_timer(0.5).timeout
	player.get_node("PlayerCamera").position_smoothing_enabled = false
	player.on_states_reset()
	player.jump_marker.visible = true

func _on_boss_summon_circle_raise_walls() -> void:
	for i in 18:
		movable_walls[i].get_node("AnimationPlayer").play("Raise")
	
func _on_tothermos_lower_walls() -> void:
	for i in 18:
		movable_walls[i].get_node("AnimationPlayer").play("Lower")
