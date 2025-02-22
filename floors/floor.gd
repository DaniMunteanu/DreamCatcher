extends Node2D

const MINIMUM_ROOMS = 20

var rooms_res = []
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

func initialize_room_resources():
	placed_rooms.resize(31)
	
	rooms_res.resize(31)
	rooms_res[0] = preload("res://rooms/Floor1_Room0.tscn")
	rooms_res[1] = preload("res://rooms/Floor1_Room1.tscn")
	rooms_res[2] = preload("res://rooms/Floor1_Room2.tscn")
	rooms_res[3] = preload("res://rooms/Floor1_Room3.tscn")
	rooms_res[4] = preload("res://rooms/Floor1_Room4.tscn")
	rooms_res[5] = preload("res://rooms/Floor1_Room5.tscn")
	rooms_res[6] = preload("res://rooms/Floor1_Room6.tscn")
	rooms_res[7] = preload("res://rooms/Floor1_Room7.tscn")
	rooms_res[8] = preload("res://rooms/Floor1_Room8.tscn")
	rooms_res[9] = preload("res://rooms/Floor1_Room9.tscn")
	rooms_res[10] = preload("res://rooms/Floor1_Room10.tscn")
	rooms_res[11] = preload("res://rooms/Floor1_Room11.tscn")
	rooms_res[12] = preload("res://rooms/Floor1_Room12.tscn")
	rooms_res[13] = preload("res://rooms/Floor1_Room13.tscn")
	rooms_res[14] = preload("res://rooms/Floor1_Room14.tscn")
	rooms_res[15] = preload("res://rooms/Floor1_Room15.tscn")
	rooms_res[16] = preload("res://rooms/Floor1_Room16.tscn")
	rooms_res[17] = preload("res://rooms/Floor1_Room17.tscn")
	rooms_res[18] = preload("res://rooms/Floor1_Room18.tscn")
	rooms_res[19] = preload("res://rooms/Floor1_Room19.tscn")
	rooms_res[20] = preload("res://rooms/Floor1_Room20.tscn")
	rooms_res[21] = preload("res://rooms/Floor1_Room21.tscn")
	rooms_res[22] = preload("res://rooms/Floor1_Room22.tscn")
	rooms_res[23] = preload("res://rooms/Floor1_Room23.tscn")
	rooms_res[24] = preload("res://rooms/Floor1_Room24.tscn")
	rooms_res[25] = preload("res://rooms/Floor1_Room25.tscn")
	rooms_res[26] = preload("res://rooms/Floor1_Room26.tscn")
	rooms_res[27] = preload("res://rooms/Floor1_Room27.tscn")
	rooms_res[28] = preload("res://rooms/Floor1_Room28.tscn")
	rooms_res[29] = preload("res://rooms/Floor1_Room29.tscn")
	rooms_res[30] = preload("res://rooms/Floor1_Room30.tscn")
	
	room_markers.resize(31)
	for i in 31:
		room_markers[i] = get_node("Marker_" + str(i))

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
		door_markers[i] = get_node("Marker_door_" + str(i))

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
	Global.clear_room.connect(_on_room_cleared)
	Global.room_entered.connect(_on_room_entered)
	initialize_room_resources()
	initialize_door_resources()
	initialize_wall_resources()
	initialize_room_pairs()
	
func reset():
	for i in 31:
		if placed_rooms[i] != null:
			placed_rooms[i].queue_free()
			placed_rooms[i].reset_room()
	placed_rooms.fill(null)
	extendable_rooms.clear()
	
	for j in 48:
		if placed_doors_or_walls[j] != null: 
			placed_doors_or_walls[j].queue_free()
	placed_doors_or_walls.fill(null)
	
	placed_doors_indexes.clear()

func generate_rooms():
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
		
		if placed_rooms[next_room].can_extend:
			extendable_rooms.append(next_room)
	
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

func generate_floor():
	reset()
	generate_rooms()
	generate_doors_and_walls()
	Global.floor_generated.emit()
	placed_rooms[0].open_room(placed_doors_or_walls, placed_doors_indexes)
	_on_room_entered(0)

func _physics_process(delta):
	if Input.is_action_just_pressed("floor_generate"):
		generate_floor()
	
func _on_room_cleared(room_index: int):
	placed_rooms[room_index].open_room(placed_doors_or_walls, placed_doors_indexes)
	
func _on_room_entered(room_index: int):
	Global.minimap_room_entered.emit(room_index, placed_rooms[room_index].neighbour_rooms)
	if placed_rooms[room_index].room_cleared == false:
		placed_rooms[room_index].close_room(placed_doors_or_walls, placed_doors_indexes)
		
