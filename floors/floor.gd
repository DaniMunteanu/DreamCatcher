extends Node2D

@onready var drop_res = preload("res://MobDrop.tscn")

const MINIMUM_ROOMS = 10

var rooms_res = []
var room_fills_res = []
var doors_res = []
var walls_res = []

var placed_rooms = []
var placed_doors_or_walls = []
var placed_doors_indexes = []

var room_pairs = []

var room_markers = []
var door_markers = []

var number_of_rooms = 0

var extendable_rooms = []
var rng = RandomNumberGenerator.new()

var floor_save_file_path = "user://FloorSaveData.tres"

func save_floor():
	var floor_data = FloorSaveData.new()
	floor_data.room_array.resize(31)
	floor_data.door_or_wall_array.resize(48)
	
	for i in 31:
		var packed_room = PackedScene.new()
		if placed_rooms[i].has_method("save_room"):
			placed_rooms[i].save_room()
		packed_room.pack(placed_rooms[i])
		floor_data.room_array[i] = packed_room
		
	for j in 48:
		var packed_door_or_wall = PackedScene.new()
		packed_door_or_wall.pack(placed_doors_or_walls[j])
		floor_data.door_or_wall_array[j] = packed_door_or_wall
		
	for index in placed_doors_indexes:
		floor_data.door_index_array.append(index)
	
	ResourceSaver.save(floor_data, floor_save_file_path)
	
func load_floor():
	var floor_data = ResourceLoader.load(floor_save_file_path) as FloorSaveData
	
	for i in 31:
		var room_node = floor_data.room_array[i].instantiate()
		add_child(room_node)
		placed_rooms[i] = room_node
		if placed_rooms[i].has_method("load_room"):
			placed_rooms[i].load_room()
			
	if placed_rooms[0].is_ongoing_boss_fight:
		placed_rooms[0].instant_raise_walls()
		Global.boss_summoned.emit()
		
	for j in 48:
		var door_or_wall_node = floor_data.door_or_wall_array[j].instantiate()
		add_child(door_or_wall_node)
		placed_doors_or_walls[j] = door_or_wall_node
		
	for index in floor_data.door_index_array:
		placed_doors_indexes.append(index)
	floor_data.door_index_array.clear()
	
func initialize_room_resources():
	placed_rooms.resize(31)
	rooms_res.resize(31)
	room_markers.resize(31)
	
	for i in 31:
		rooms_res[i] = load("res://rooms/Floor1_Room" + str(i) + ".tscn")
		room_markers[i] = $FloorTemplate.get_node("RoomMarkers/Marker_" + str(i))

func initialize_room_fills_resources():
	room_fills_res.resize(31)
	for i in range(1,31):
		room_fills_res[i] = load("res://room_fills/RoomFill" + str(i) + ".tscn")

func initialize_door_resources():
	placed_doors_or_walls.resize(48)
	doors_res.resize(48)
	
	var door_horizontal = preload("res://doors/DoorHorizontal.tscn")
	var door_vertical = preload("res://doors/DoorVertical.tscn")
	var door_left = preload("res://doors/DoorLeft.tscn")
	var door_left_top = preload("res://doors/DoorLeftTop.tscn")
	var door_right = preload("res://doors/DoorRight.tscn")
	var door_right_top = preload("res://doors/DoorRightTop.tscn")
	
	doors_res[0] = door_vertical
	doors_res[1] = door_horizontal
	doors_res[2] = door_vertical
	doors_res[3] = door_vertical
	doors_res[4] = door_horizontal
	doors_res[5] = door_vertical
	doors_res[6] = door_horizontal
	doors_res[7] = door_vertical
	doors_res[8] = door_vertical
	doors_res[9] = door_horizontal
	doors_res[10] = door_vertical
	doors_res[11] = door_right
	doors_res[12] = door_left
	doors_res[13] = door_vertical
	doors_res[14] = door_right
	doors_res[15] = door_left
	doors_res[16] = door_left
	doors_res[17] = door_right
	doors_res[18] = door_vertical
	doors_res[19] = door_left
	doors_res[20] = door_right
	doors_res[21] = door_vertical
	doors_res[22] = door_left
	doors_res[23] = door_right
	doors_res[24] = door_vertical
	doors_res[25] = door_left
	doors_res[26] = door_right
	doors_res[27] = door_vertical
	doors_res[28] = door_left
	doors_res[29] = door_vertical
	doors_res[30] = door_right
	doors_res[31] = door_horizontal
	doors_res[32] = door_left
	doors_res[33] = door_vertical
	doors_res[34] = door_right
	doors_res[35] = door_horizontal
	doors_res[36] = door_left_top
	doors_res[37] = door_horizontal
	doors_res[38] = door_right
	doors_res[39] = door_left
	doors_res[40] = door_horizontal
	doors_res[41] = door_right_top
	doors_res[42] = door_left_top
	doors_res[43] = door_horizontal
	doors_res[44] = door_right
	doors_res[45] = door_left
	doors_res[46] = door_horizontal
	doors_res[47] = door_right_top
	
	door_markers.resize(48)
	for i in 48:
		door_markers[i] = $FloorTemplate.get_node("DoorMarkers/Marker_door_" + str(i))

func initialize_wall_resources():
	walls_res.resize(48)
	
	var single_wall = preload("res://walls/Wall1.tscn")
	var horizontal_wall = preload("res://walls/Wall2_horizontal.tscn")
	var vertical_wall = preload("res://walls/Wall2_vertical.tscn")
	var triple_vertical_wall = preload("res://walls/Wall3_vertical.tscn")
	
	walls_res[0] = vertical_wall
	walls_res[1] = horizontal_wall
	walls_res[2] = vertical_wall
	walls_res[3] = vertical_wall
	walls_res[4] = horizontal_wall
	walls_res[5] = vertical_wall
	walls_res[6] = horizontal_wall
	walls_res[7] = vertical_wall
	walls_res[8] = vertical_wall
	walls_res[9] = horizontal_wall
	walls_res[10] = vertical_wall
	walls_res[11] = single_wall
	walls_res[12] = single_wall
	walls_res[13] = vertical_wall
	walls_res[14] = single_wall
	walls_res[15] = single_wall
	walls_res[16] = single_wall
	walls_res[17] = single_wall
	walls_res[18] = vertical_wall
	walls_res[19] = single_wall
	walls_res[20] = single_wall
	walls_res[21] = vertical_wall
	walls_res[22] = single_wall
	walls_res[23] = single_wall
	walls_res[24] = vertical_wall
	walls_res[25] = single_wall
	walls_res[26] = single_wall
	walls_res[27] = vertical_wall
	walls_res[28] = single_wall
	walls_res[29] = vertical_wall
	walls_res[30] = single_wall
	walls_res[31] = horizontal_wall
	walls_res[32] = single_wall
	walls_res[33] = vertical_wall
	walls_res[34] = single_wall
	walls_res[35] = horizontal_wall
	walls_res[36] = triple_vertical_wall
	walls_res[37] = horizontal_wall
	walls_res[38] = single_wall
	walls_res[39] = single_wall
	walls_res[40] = horizontal_wall
	walls_res[41] = triple_vertical_wall
	walls_res[42] = triple_vertical_wall
	walls_res[43] = horizontal_wall
	walls_res[44] = single_wall
	walls_res[45] = single_wall
	walls_res[46] = horizontal_wall
	walls_res[47] = triple_vertical_wall

func initialize_room_pairs():
	room_pairs.resize(48)
	
	room_pairs[0] = [0,1]
	room_pairs[1] = [2,0]
	room_pairs[2] = [0,2]
	room_pairs[3] = [3,0]
	room_pairs[4] = [3,0]
	room_pairs[5] = [4,0]
	room_pairs[6] = [0,5]
	room_pairs[7] = [5,0]
	room_pairs[8] = [0,6]
	room_pairs[9] = [0,6]
	room_pairs[10] = [1,7]
	room_pairs[11] = [9,2]
	room_pairs[12] = [11,3]
	room_pairs[13] = [13,4]
	room_pairs[14] = [5,15]
	room_pairs[15] = [6,17]
	room_pairs[16] = [7,18]
	room_pairs[17] = [8,7]
	room_pairs[18] = [9,8]
	room_pairs[19] = [10,9]
	room_pairs[20] = [10,11]
	room_pairs[21] = [12,11]
	room_pairs[22] = [12,13]
	room_pairs[23] = [13,14]
	room_pairs[24] = [14,15]
	room_pairs[25] = [15,16]
	room_pairs[26] = [17,16]
	room_pairs[27] = [17,18]
	room_pairs[28] = [18,30]
	room_pairs[29] = [7,19]
	room_pairs[30] = [20,8]
	room_pairs[31] = [22,10]
	room_pairs[32] = [24,12]
	room_pairs[33] = [25,13]
	room_pairs[34] = [14,26]
	room_pairs[35] = [16,28]
	room_pairs[36] = [28,29]
	room_pairs[37] = [30,29]
	room_pairs[38] = [19,30]
	room_pairs[39] = [20,19]
	room_pairs[40] = [21,20]
	room_pairs[41] = [21,22]
	room_pairs[42] = [23,22]
	room_pairs[43] = [23,24]
	room_pairs[44] = [24,25]
	room_pairs[45] = [25,26]
	room_pairs[46] = [26,27]
	room_pairs[47] = [28,27]

func _ready():
	initialize_room_resources()
	initialize_room_fills_resources()
	initialize_door_resources()
	initialize_wall_resources()
	initialize_room_pairs()
	
	Global.clear_room.connect(_on_room_cleared)
	Global.room_entered.connect(_on_room_entered)
	Global.enemy_dead.connect(_on_enemy_dead)
	Global.pause_game.connect(_on_pause_game)
	Global.unpause_game.connect(_on_unpause_game)
	
	TransitionScreen.ready_for_fade_out.emit()
	
	BackgroundMusic.play_audio(BackgroundMusic.floor_audio)
	
func reset():
	for i in 31:
		placed_rooms[i].queue_free()
	placed_rooms.fill(null)
	extendable_rooms.clear()
	
	for j in 48:
		if placed_doors_or_walls[j] != null: 
			placed_doors_or_walls[j].queue_free()
	placed_doors_or_walls.fill(null)
	
	placed_doors_indexes.clear()

func generate_rooms():
	var potential_shop_spawn_rooms = []
	
	number_of_rooms = rng.randi_range(MINIMUM_ROOMS, MINIMUM_ROOMS+2)
	
	placed_rooms[0] = rooms_res[0].instantiate()
	placed_rooms[0].global_position = room_markers[0].global_position
	
	add_child(placed_rooms[0])
	extendable_rooms.append(0)
	
	for i in range (1,number_of_rooms):
		var room_to_extend = extendable_rooms.pick_random()
		
		var next_room = placed_rooms[room_to_extend].next_room()
		placed_rooms[next_room] = rooms_res[next_room].instantiate()
		placed_rooms[next_room].global_position = room_markers[next_room].global_position
		placed_rooms[next_room].update_neighbours(placed_rooms, extendable_rooms)
		add_child(placed_rooms[next_room])
		potential_shop_spawn_rooms.append(next_room)
		
		if placed_rooms[next_room].can_extend:
			extendable_rooms.append(next_room)
	
	var shop_room_index = potential_shop_spawn_rooms.pick_random()
	placed_rooms[shop_room_index].is_shop_room = true
	Global.shop_room_picked.emit(shop_room_index)
	
func generate_doors_and_walls():
	for j in 48:
		var new_door_or_wall
		if (placed_rooms[room_pairs[j][0]] != null) and (placed_rooms[room_pairs[j][1]] != null):
			new_door_or_wall = doors_res[j].instantiate()
			new_door_or_wall.set_rooms(room_pairs[j][0],room_pairs[j][1])
			placed_doors_indexes.append(j)
		else:
			new_door_or_wall = walls_res[j].instantiate()
		new_door_or_wall.global_position = door_markers[j].global_position
		add_child(new_door_or_wall)
		placed_doors_or_walls[j] = new_door_or_wall

func generate_room_fills():
	for i in 31:
		if placed_rooms[i] == null:
			placed_rooms[i] = room_fills_res[i].instantiate()
			placed_rooms[i].global_position = room_markers[i].global_position
			add_child(placed_rooms[i])

func generate_floor():
	initialize_room_resources()
	initialize_room_fills_resources()
	initialize_door_resources()
	initialize_wall_resources()
	initialize_room_pairs()
	
	generate_rooms()
	generate_doors_and_walls()
	generate_room_fills()
	Global.floor_generated.emit()
	placed_rooms[0].open_room(placed_doors_or_walls, placed_doors_indexes)
	Global.room_entered.emit(0,0)
	
func _on_room_cleared(room_index: int):
	placed_rooms[room_index].open_room(placed_doors_or_walls, placed_doors_indexes)
	
func _on_room_entered(entered_room_index: int, left_room_index: int):
	$Player.camera.position_smoothing_enabled = true
	$Player.camera.position_smoothing_speed = 2.0
	Global.minimap_room_entered.emit(entered_room_index, placed_rooms[entered_room_index].neighbour_rooms)
	if placed_rooms[entered_room_index].room_cleared == false:
		placed_rooms[entered_room_index].close_room(placed_doors_or_walls, placed_doors_indexes)
	
	placed_rooms[entered_room_index].clear_fog()
	if entered_room_index != left_room_index:
		placed_rooms[left_room_index].place_fog()
		
	#Camera smoothing doar in timpul tranzitiei dintre camere
	await get_tree().create_timer(0.1).timeout
	$Player.camera.position_smoothing_speed = 3.0
	await get_tree().create_timer(0.1).timeout
	$Player.camera.position_smoothing_speed = 4.0
	await get_tree().create_timer(0.1).timeout
	$Player.camera.position_smoothing_speed = 6.0
	await get_tree().create_timer(0.1).timeout
	$Player.camera.position_smoothing_speed = 8.0
	await get_tree().create_timer(0.1).timeout
	$Player.camera.position_smoothing_enabled = false
	
func _on_enemy_dead(enemy_death_position: Vector2):
	var new_drop = drop_res.instantiate()
	new_drop.global_position = enemy_death_position
	new_drop.pick_drop()
	add_child(new_drop)
	new_drop.set_owner(self)

func _on_pause_game() -> void:
	get_tree().paused = true
	
func _on_unpause_game() -> void:
	get_tree().paused = false
