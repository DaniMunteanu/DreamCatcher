extends FloorRoom

func _init():
	room_index = 5
	available_rooms = [0,15]
	potential_doors = [6,7,14]
	can_extend = true
	
func reset_room():
	available_rooms = [0,15]
	can_extend = true
