extends FloorRoom

func _init():
	room_index = 25
	available_rooms = [13,24,26]
	potential_doors = [33,44,45]
	can_extend = true
	
func reset_room():
	available_rooms = [13,24,26]
	can_extend = true
