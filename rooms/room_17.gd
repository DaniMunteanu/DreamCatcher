extends FloorRoom

func _init():
	room_index = 17
	available_rooms = [6,16,18]
	potential_doors = [15,26,27]
	can_extend = true
	
func reset_room():
	available_rooms = [6,16,18]
	can_extend = true
