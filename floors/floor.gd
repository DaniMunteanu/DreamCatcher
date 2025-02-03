extends Node2D

const MINIMUM_ROOMS = 10

var rooms_res = []
var placed_rooms = []
var markers = []

var number_of_rooms = 0

func initialize_resources():
	placed_rooms.resize(31)
	
	rooms_res.resize(31)
	rooms_res[0] = preload("res://rooms/Floor1_Center.tscn")
	rooms_res[1] = preload("res://rooms/Floor1_W1.tscn")
	rooms_res[2] = preload("res://rooms/Floor1_NW1.tscn")
	rooms_res[3] = preload("res://rooms/Floor1_NE1.tscn")
	rooms_res[4] = preload("res://rooms/Floor1_E1.tscn")
	rooms_res[5] = preload("res://rooms/Floor1_SE1.tscn")
	rooms_res[6] = preload("res://rooms/Floor1_SW1.tscn")
	rooms_res[7] = preload("res://rooms/Floor1_W2.tscn")
	rooms_res[8] = preload("res://rooms/Floor1_WN2.tscn")
	rooms_res[9] = preload("res://rooms/Floor1_NW2.tscn")
	rooms_res[10] = preload("res://rooms/Floor1_N2.tscn")
	rooms_res[11] = preload("res://rooms/Floor1_NE2.tscn")
	rooms_res[12] = preload("res://rooms/Floor1_EN2.tscn")
	rooms_res[13] = preload("res://rooms/Floor1_E2.tscn")
	rooms_res[14] = preload("res://rooms/Floor1_ES2.tscn")
	rooms_res[15] = preload("res://rooms/Floor1_SE2.tscn")
	rooms_res[16] = preload("res://rooms/Floor1_S2.tscn")
	rooms_res[17] = preload("res://rooms/Floor1_SW2.tscn")
	rooms_res[18] = preload("res://rooms/Floor1_WS2.tscn")
	rooms_res[19] = preload("res://rooms/Floor1_W3.tscn")
	rooms_res[20] = preload("res://rooms/Floor1_WN3.tscn")
	rooms_res[21] = preload("res://rooms/Floor1_NW3.tscn")
	rooms_res[22] = preload("res://rooms/Floor1_N3.tscn")
	rooms_res[23] = preload("res://rooms/Floor1_NE3.tscn")
	rooms_res[24] = preload("res://rooms/Floor1_EN3.tscn")
	rooms_res[25] = preload("res://rooms/Floor1_E3.tscn")
	rooms_res[26] = preload("res://rooms/Floor1_ES3.tscn")
	rooms_res[27] = preload("res://rooms/Floor1_SE3.tscn")
	rooms_res[28] = preload("res://rooms/Floor1_S3.tscn")
	rooms_res[29] = preload("res://rooms/Floor1_SW3.tscn")
	rooms_res[30] = preload("res://rooms/Floor1_WS3.tscn")
	
	markers.resize(31)
	markers[0] = get_node("Marker_0")
	markers[1] = get_node("Marker_1")
	markers[2] = get_node("Marker_2")
	markers[3] = get_node("Marker_3")
	markers[4] = get_node("Marker_4")
	markers[5] = get_node("Marker_5")
	markers[6] = get_node("Marker_6")
	markers[7] = get_node("Marker_7")
	markers[8] = get_node("Marker_8")
	markers[9] = get_node("Marker_9")
	markers[10] = get_node("Marker_10")
	markers[11] = get_node("Marker_11")
	markers[12] = get_node("Marker_12")
	markers[13] = get_node("Marker_13")
	markers[14] = get_node("Marker_14")
	markers[15] = get_node("Marker_15")
	markers[16] = get_node("Marker_16")
	markers[17] = get_node("Marker_17")
	markers[18] = get_node("Marker_18")
	markers[19] = get_node("Marker_19")
	markers[20] = get_node("Marker_20")
	markers[21] = get_node("Marker_22")
	markers[22] = get_node("Marker_22")
	markers[23] = get_node("Marker_23")
	markers[24] = get_node("Marker_24")
	markers[25] = get_node("Marker_25")
	markers[26] = get_node("Marker_26")
	markers[27] = get_node("Marker_27")
	markers[28] = get_node("Marker_28")
	markers[29] = get_node("Marker_29")
	markers[30] = get_node("Marker_30")

func _ready():
	initialize_resources()
	
func reset():
	for i in 30:
		if placed_rooms[i] != null:
			placed_rooms[i].queue_free()
			placed_rooms[i].reset_room()
	placed_rooms.fill(null)

func generate():
	reset()
	
	var rng = RandomNumberGenerator.new()
	number_of_rooms = rng.randi_range(MINIMUM_ROOMS, MINIMUM_ROOMS+2)
	print("------------------------------")
	print("Number of generated rooms is ", number_of_rooms)
	
	var extendable_rooms = []
	
	placed_rooms[0] = rooms_res[0].instantiate()
	placed_rooms[0].global_position = markers[0].global_position
	
	#placed_rooms[0].update_neighbours(placed_rooms, extendable_rooms)
	
	add_child(placed_rooms[0])
	extendable_rooms.append(0)
	
	for i in range (1,number_of_rooms):
		var room_to_extend = extendable_rooms.pick_random()
		print("Room to be extended is ", room_to_extend)
		
		var next_room = placed_rooms[room_to_extend].next_room()
		print("New room is ", next_room)
		
		placed_rooms[next_room] = rooms_res[next_room].instantiate()
		placed_rooms[next_room].global_position = markers[next_room].global_position
		placed_rooms[next_room].update_neighbours(placed_rooms, extendable_rooms)
		add_child(placed_rooms[next_room])
		
		if placed_rooms[next_room].can_extend:
			extendable_rooms.append(next_room)

func _physics_process(delta):
	if Input.is_action_just_pressed("floor_generate"):
		generate()
	
	
