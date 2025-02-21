extends Control

var rooms = []
var rooms_res = []
var rooms_isDiscovered = []

func reset():
	for i in 31:
		rooms[i].visible = false
		rooms[i].texture = rooms_res[i][0]
	rooms_isDiscovered.fill(false)

func build_rooms_array():
	rooms.resize(31)
	for i in 31:
		rooms[i] = get_node("AspectRatioContainer/Room" + str(i) + "/TextureRect")

func initialize_rooms_res():
	rooms_res.resize(31)
	for i in 31:
		rooms_res[i] = ["","",""]
		for j in 3:
			rooms_res[i][j] = load("res://Sprites/Minimap/MinimapRoom" + str(i) + "_" + str(j) + ".png")

func reveal_room(room_index: int):
	rooms[room_index].visible = true

func set_current_room(room_index: int):
	rooms[room_index].texture = rooms_res[room_index][1]
	rooms_isDiscovered[room_index] = true

func set_left_room(room_index: int):
	rooms[room_index].texture = rooms_res[room_index][2]
	
func _on_minimap_room_entered(room_index: int, neighbour_rooms_indices: Array):
	set_current_room(room_index)
	for room in neighbour_rooms_indices:
		if rooms_isDiscovered[room]:
			set_left_room(room)
		else:
			reveal_room(room)

func _ready() -> void:
	Global.minimap_room_entered.connect(_on_minimap_room_entered)
	build_rooms_array()
	initialize_rooms_res()
	rooms_isDiscovered.resize(31)
	rooms[0].visible = true
	
func _physics_process(delta):
	if Input.is_action_just_pressed("floor_generate"):
		reset()
	
