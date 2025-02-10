extends FloorRoom

func _init():
	room_index = 6
	available_rooms = [0,17]
	potential_doors = [8,9,15]
	can_extend = true
	
func reset_room():
	available_rooms = [0,17]
	can_extend = true
