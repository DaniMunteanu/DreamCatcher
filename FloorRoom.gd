class_name FloorRoom

extends Node2D

var room_index = 0
var neighbour_rooms = []
var available_rooms = []
var can_extend = true
var room_cleared = false
var potential_doors = []

func open_room(placed_doors_or_walls: Array, placed_doors_indexes: Array):
	for i in potential_doors:
		if i in placed_doors_indexes:
			placed_doors_or_walls[i].open_door()
	room_cleared = true
	
func close_room(placed_doors_or_walls: Array, placed_doors_indexes: Array):
	for i in potential_doors:
		if i in placed_doors_indexes:
			placed_doors_or_walls[i].close_door()
	place_enemies()
			
func place_enemies():
	pass

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
