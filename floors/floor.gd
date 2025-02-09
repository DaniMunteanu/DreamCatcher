extends Node2D

const MINIMUM_ROOMS = 6

var rooms_res = []
var doors_res = []

var placed_rooms = []
var placed_doors = []
var room_pairs = []

var room_markers = []
var door_markers = []

var number_of_rooms = 0

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
	room_markers[0] = get_node("Marker_0")
	room_markers[1] = get_node("Marker_1")
	room_markers[2] = get_node("Marker_2")
	room_markers[3] = get_node("Marker_3")
	room_markers[4] = get_node("Marker_4")
	room_markers[5] = get_node("Marker_5")
	room_markers[6] = get_node("Marker_6")
	room_markers[7] = get_node("Marker_7")
	room_markers[8] = get_node("Marker_8")
	room_markers[9] = get_node("Marker_9")
	room_markers[10] = get_node("Marker_10")
	room_markers[11] = get_node("Marker_11")
	room_markers[12] = get_node("Marker_12")
	room_markers[13] = get_node("Marker_13")
	room_markers[14] = get_node("Marker_14")
	room_markers[15] = get_node("Marker_15")
	room_markers[16] = get_node("Marker_16")
	room_markers[17] = get_node("Marker_17")
	room_markers[18] = get_node("Marker_18")
	room_markers[19] = get_node("Marker_19")
	room_markers[20] = get_node("Marker_20")
	room_markers[21] = get_node("Marker_21")
	room_markers[22] = get_node("Marker_22")
	room_markers[23] = get_node("Marker_23")
	room_markers[24] = get_node("Marker_24")
	room_markers[25] = get_node("Marker_25")
	room_markers[26] = get_node("Marker_26")
	room_markers[27] = get_node("Marker_27")
	room_markers[28] = get_node("Marker_28")
	room_markers[29] = get_node("Marker_29")
	room_markers[30] = get_node("Marker_30")

func initialize_door_resources():
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
	door_markers[0] = get_node("Marker_door_0")
	door_markers[1] = get_node("Marker_door_1")
	door_markers[2] = get_node("Marker_door_2")
	door_markers[3] = get_node("Marker_door_3")
	door_markers[4] = get_node("Marker_door_4")
	door_markers[5] = get_node("Marker_door_5")
	door_markers[6] = get_node("Marker_door_6")
	door_markers[7] = get_node("Marker_door_7")
	door_markers[8] = get_node("Marker_door_8")
	door_markers[9] = get_node("Marker_door_9")
	door_markers[10] = get_node("Marker_door_10")
	door_markers[11] = get_node("Marker_door_11")
	door_markers[12] = get_node("Marker_door_12")
	door_markers[13] = get_node("Marker_door_13")
	door_markers[14] = get_node("Marker_door_14")
	door_markers[15] = get_node("Marker_door_15")
	door_markers[16] = get_node("Marker_door_16")
	door_markers[17] = get_node("Marker_door_17")
	door_markers[18] = get_node("Marker_door_18")
	door_markers[19] = get_node("Marker_door_19")
	door_markers[20] = get_node("Marker_door_20")
	door_markers[21] = get_node("Marker_door_21")
	door_markers[22] = get_node("Marker_door_22")
	door_markers[23] = get_node("Marker_door_23")
	door_markers[24] = get_node("Marker_door_24")
	door_markers[25] = get_node("Marker_door_25")
	door_markers[26] = get_node("Marker_door_26")
	door_markers[27] = get_node("Marker_door_27")
	door_markers[28] = get_node("Marker_door_28")
	door_markers[29] = get_node("Marker_door_29")
	door_markers[30] = get_node("Marker_door_30")
	door_markers[31] = get_node("Marker_door_31")
	door_markers[32] = get_node("Marker_door_32")
	door_markers[33] = get_node("Marker_door_33")
	door_markers[34] = get_node("Marker_door_34")
	door_markers[35] = get_node("Marker_door_35")
	door_markers[36] = get_node("Marker_door_36")
	door_markers[37] = get_node("Marker_door_37")
	door_markers[38] = get_node("Marker_door_38")
	door_markers[39] = get_node("Marker_door_39")
	door_markers[40] = get_node("Marker_door_40")
	door_markers[41] = get_node("Marker_door_41")
	door_markers[42] = get_node("Marker_door_42")
	door_markers[43] = get_node("Marker_door_43")
	door_markers[44] = get_node("Marker_door_44")
	door_markers[45] = get_node("Marker_door_45")
	door_markers[46] = get_node("Marker_door_46")
	door_markers[47] = get_node("Marker_door_47")

func initialize_room_pairs():
	room_pairs.resize(48)
	
	room_pairs[0] = [0,1]
	room_pairs[1] = [0,2]
	room_pairs[2] = [0,2]
	room_pairs[3] = [0,3]
	room_pairs[4] = [0,3]
	room_pairs[5] = [0,4]
	room_pairs[6] = [0,5]
	room_pairs[7] = [0,5]
	room_pairs[8] = [0,6]
	room_pairs[9] = [0,6]
	room_pairs[10] = [1,7]
	room_pairs[11] = [2,9]
	room_pairs[12] = [3,11]
	room_pairs[13] = [4,13]
	room_pairs[14] = [5,15]
	room_pairs[15] = [6,17]
	room_pairs[16] = [7,18]
	room_pairs[17] = [7,8]
	room_pairs[18] = [8,9]
	room_pairs[19] = [9,10]
	room_pairs[20] = [10,11]
	room_pairs[21] = [11,12]
	room_pairs[22] = [12,13]
	room_pairs[23] = [13,14]
	room_pairs[24] = [14,15]
	room_pairs[25] = [15,16]
	room_pairs[26] = [16,17]
	room_pairs[27] = [17,18]
	room_pairs[28] = [18,30]
	room_pairs[29] = [7,19]
	room_pairs[30] = [8,20]
	room_pairs[31] = [10,22]
	room_pairs[32] = [12,24]
	room_pairs[33] = [13,25]
	room_pairs[34] = [14,26]
	room_pairs[35] = [16,28]
	room_pairs[36] = [28,29]
	room_pairs[37] = [29,30]
	room_pairs[38] = [19,30]
	room_pairs[39] = [19,20]
	room_pairs[40] = [20,21]
	room_pairs[41] = [21,22]
	room_pairs[42] = [22,23]
	room_pairs[43] = [23,24]
	room_pairs[44] = [24,25]
	room_pairs[45] = [25,26]
	room_pairs[46] = [26,27]
	room_pairs[47] = [27,28]
	
func _ready():
	initialize_room_resources()
	initialize_door_resources()
	initialize_room_pairs()
	
func reset():
	for i in 31:
		if placed_rooms[i] != null:
			placed_rooms[i].queue_free()
			placed_rooms[i].reset_room()
	placed_rooms.fill(null)
	
	for j in placed_doors.size():
		placed_doors[j].queue_free()
	placed_doors.clear()

func generate():
	reset()
	
	var rng = RandomNumberGenerator.new()
	number_of_rooms = rng.randi_range(MINIMUM_ROOMS, MINIMUM_ROOMS+2)
	print("------------------------------")
	print("Number of generated rooms is ", number_of_rooms)
	
	var extendable_rooms = []
	
	placed_rooms[0] = rooms_res[0].instantiate()
	placed_rooms[0].global_position = room_markers[0].global_position
	
	add_child(placed_rooms[0])
	extendable_rooms.append(0)
	
	for i in range (1,number_of_rooms):
		var room_to_extend = extendable_rooms.pick_random()
		print("Room to be extended is ", room_to_extend)
		
		var next_room = placed_rooms[room_to_extend].next_room()
		print("New room is ", next_room)
		
		placed_rooms[next_room] = rooms_res[next_room].instantiate()
		placed_rooms[next_room].global_position = room_markers[next_room].global_position
		placed_rooms[next_room].update_neighbours(placed_rooms, extendable_rooms)
		add_child(placed_rooms[next_room])
		
		if placed_rooms[next_room].can_extend:
			extendable_rooms.append(next_room)
	
	for j in 48:
		if (placed_rooms[room_pairs[j][0]] != null) and (placed_rooms[room_pairs[j][1]] != null):
			var new_door = doors_res[j].instantiate()
			placed_doors.append(new_door)
			new_door.global_position = door_markers[j].global_position
			add_child(new_door)
			

func _physics_process(delta):
	if Input.is_action_just_pressed("floor_generate"):
		generate()
	
	
