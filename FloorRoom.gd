class_name FloorRoom

extends Node2D

@onready var SHOPKEEPER = preload("res://Smeet.tscn")

@export var room_index = 0
@export var neighbour_rooms = []
@export var available_rooms = []
@export var can_extend = true

@export var room_cleared = false
@export var potential_doors = []

@export var is_ongoing_encounter = false

var enemies
var room_data_save_file_path

func _ready() -> void:
	var enemies_res = load("res://room_enemies/Enemies" + str(room_index) + "_0.tscn")
	enemies = enemies_res.instantiate()
	enemies.connect("enemies_defeated",_on_enemies_defeated)

func save_room():
	room_data_save_file_path = "user://SaveDataRoom" + str(room_index) + ".tres"
	var room_data = RoomSaveData.new()
	var packed_enemies = PackedScene.new()
	
	if enemies != null:
		packed_enemies.pack(enemies)
	else:
		packed_enemies = null
	
	room_data.room_enemies = packed_enemies
	room_data.room_cleared = room_cleared
	ResourceSaver.save(room_data, room_data_save_file_path)
	
func load_room():
	room_data_save_file_path = "user://SaveDataRoom" + str(room_index) + ".tres"
	var room_data = ResourceLoader.load(room_data_save_file_path) as RoomSaveData
	room_cleared = room_data.room_cleared
	if room_data.room_enemies != null:
		enemies = room_data.room_enemies.instantiate()
		enemies.connect("enemies_defeated",_on_enemies_defeated)
		if is_ongoing_encounter == true:
			place_enemies()
			
func spawn_shop():
	var shopkeeper_instance = SHOPKEEPER.instantiate()
	shopkeeper_instance.position = $ShopSpawnMarker.position
	add_child(shopkeeper_instance)
	shopkeeper_instance.set_owner(self)

func open_room(placed_doors_or_walls: Array, placed_doors_indexes: Array):
	for i in potential_doors:
		if i in placed_doors_indexes:
			placed_doors_or_walls[i].open_door()
	room_cleared = true
	is_ongoing_encounter = false
	
func close_room(placed_doors_or_walls: Array, placed_doors_indexes: Array):
	for i in potential_doors:
		if i in placed_doors_indexes:
			placed_doors_or_walls[i].close_door()
	place_enemies()
	is_ongoing_encounter = true
	
func _on_enemies_defeated() -> void:
	Global.clear_room.emit(room_index)
	
func place_enemies():
	call_deferred("add_child",enemies)

func next_room() -> int:
	var picked_room = available_rooms.pick_random()
	available_rooms.erase(picked_room)
	if not neighbour_rooms.has(picked_room):
		neighbour_rooms.append(picked_room)
	if available_rooms.is_empty():
		can_extend = false
	return picked_room
	
func update_neighbours(placed_rooms: Array, extendable_rooms: Array):
	var to_be_removed = []
	
	for i in available_rooms:
		if placed_rooms[i] != null:
			to_be_removed.append(i)
			if not neighbour_rooms.has(i):
				neighbour_rooms.append(i)
			
	for j in to_be_removed:
		available_rooms.erase(j)
		placed_rooms[j].available_rooms.erase(room_index)
		if not placed_rooms[j].neighbour_rooms.has(room_index):
			placed_rooms[j].neighbour_rooms.append(room_index)
		if placed_rooms[j].available_rooms.is_empty():
			placed_rooms[j].can_extend = false
			extendable_rooms.erase(j)
			
	if available_rooms.is_empty():
		can_extend = false

func reset_room():
	neighbour_rooms = []
	can_extend = true
