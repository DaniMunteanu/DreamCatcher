extends Node2D

const MINIMUM_ROOMS = 5

func initialize_resource(rooms,markers):
	rooms[0] = preload("res://rooms/Floor1_Center.tscn")
	rooms[1] = preload("res://rooms/Floor1_W1.tscn")
	rooms[2] = preload("res://rooms/Floor1_NW1.tscn")
	rooms[3] = preload("res://rooms/Floor1_NE1.tscn")
	rooms[4] = preload("res://rooms/Floor1_E1.tscn")
	rooms[5] = preload("res://rooms/Floor1_SE1.tscn")
	rooms[6] = preload("res://rooms/Floor1_SW1.tscn")
	rooms[7] = preload("res://rooms/Floor1_W2.tscn")
	rooms[8] = preload("res://rooms/Floor1_WN2.tscn")
	rooms[9] = preload("res://rooms/Floor1_NW2.tscn")
	rooms[10] = preload("res://rooms/Floor1_N2.tscn")
	rooms[11] = preload("res://rooms/Floor1_NE2.tscn")
	rooms[12] = preload("res://rooms/Floor1_EN2.tscn")
	rooms[13] = preload("res://rooms/Floor1_E2.tscn")
	rooms[14] = preload("res://rooms/Floor1_ES2.tscn")
	rooms[15] = preload("res://rooms/Floor1_SE2.tscn")
	rooms[16] = preload("res://rooms/Floor1_S2.tscn")
	rooms[17] = preload("res://rooms/Floor1_SW2.tscn")
	rooms[18] = preload("res://rooms/Floor1_WS2.tscn")
	rooms[19] = preload("res://rooms/Floor1_W3.tscn")
	rooms[20] = preload("res://rooms/Floor1_WN3.tscn")
	rooms[21] = preload("res://rooms/Floor1_NW3.tscn")
	rooms[22] = preload("res://rooms/Floor1_N3.tscn")
	rooms[23] = preload("res://rooms/Floor1_NE3.tscn")
	rooms[24] = preload("res://rooms/Floor1_EN3.tscn")
	rooms[25] = preload("res://rooms/Floor1_E3.tscn")
	rooms[26] = preload("res://rooms/Floor1_ES3.tscn")
	rooms[27] = preload("res://rooms/Floor1_SE3.tscn")
	rooms[28] = preload("res://rooms/Floor1_S3.tscn")
	rooms[29] = preload("res://rooms/Floor1_SW3.tscn")
	rooms[30] = preload("res://rooms/Floor1_WS3.tscn")
	
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
	print(get_node("Room_0").neighbours[1])
	generate()

func generate():
	var rng = RandomNumberGenerator.new()
	var number_of_rooms = rng.randf_range(MINIMUM_ROOMS, MINIMUM_ROOMS+2)
	
	var placed_rooms = []
	
	var rooms_resource = []
	rooms_resource.resize(31)
	
	var markers_resource = []
	markers_resource.resize(31)
	
	placed_rooms.resize(number_of_rooms)
	
