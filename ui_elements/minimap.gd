extends Control

var minimap_save_file_path = "user://SavedMinimap.tres"
var minimap_saved_data = MinimapSave.new()

var rooms = []
var rooms_res = []
var rooms_is_discovered = []

func save_data():
	for i in 31:
		minimap_saved_data.rooms_texture[i] = rooms[i].texture
		minimap_saved_data.rooms_visibility[i] = rooms[i].visible
		minimap_saved_data.rooms_is_discovered[i] = rooms_is_discovered[i]
	ResourceSaver.save(minimap_saved_data, minimap_save_file_path)
		
func load_data():
	build_rooms_array()
	initialize_rooms_res()
	rooms_is_discovered.resize(31)
	
	minimap_saved_data = ResourceLoader.load(minimap_save_file_path).duplicate(true)
	for i in 31:
		rooms[i].texture = minimap_saved_data.rooms_texture[i]
		rooms[i].visible = minimap_saved_data.rooms_visibility[i]
		rooms_is_discovered[i] = minimap_saved_data.rooms_is_discovered[i]

func reset():
	build_rooms_array()
	initialize_rooms_res()
	rooms_is_discovered.resize(31)
	
	for i in 31:
		rooms[i].visible = false
		rooms[i].texture = rooms_res[i][0]
	rooms_is_discovered.fill(false)

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
	rooms[room_index].visible = true
	rooms[room_index].texture = rooms_res[room_index][1]
	rooms_is_discovered[room_index] = true

func set_left_room(room_index: int):
	rooms[room_index].visible = true
	rooms[room_index].texture = rooms_res[room_index][2]
	
func _on_minimap_room_entered(room_index: int, neighbour_rooms_indices: Array):
	set_current_room(room_index)
	for room in neighbour_rooms_indices:
		if rooms_is_discovered[room]:
			set_left_room(room)
		else:
			reveal_room(room)
	
func _ready() -> void:
	Global.save_minimap.connect(save_data)
	Global.load_saved_minimap.connect(load_data)
	#reset()
	Global.minimap_room_entered.connect(_on_minimap_room_entered)
	Global.floor_generated.connect(reset)
	

	
