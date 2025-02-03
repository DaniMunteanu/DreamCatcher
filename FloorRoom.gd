class_name FloorRoom

extends Node2D

var room_index = 0
var neighbour_rooms = []
var available_rooms = []
var can_extend = true

func next_room() -> int:
	var picked_room = available_rooms.pick_random()
	available_rooms.erase(picked_room)
	if available_rooms.is_empty():
		can_extend = false
	return picked_room
	
func update_neighbours(placed_rooms: Array, extendable_rooms: Array):
	for i in available_rooms:
		if placed_rooms[i] != null:
			available_rooms.erase(i)
			placed_rooms[i].available_rooms.erase(room_index)
			if placed_rooms[i].available_rooms.is_empty():
				placed_rooms[i].can_extend = false
				extendable_rooms.erase(i)
	if available_rooms.is_empty():
		can_extend = false
	print("Available entrances for room ", room_index, " are ", available_rooms)

func reset_room():
	assert(false, "Please override `reset_room()` in the derived script.")
