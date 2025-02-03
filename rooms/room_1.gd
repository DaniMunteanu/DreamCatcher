extends FloorRoom

func _init():
	room_index = 1
	available_rooms = [0,7]
	can_extend = true
	
func reset_room():
	available_rooms = [0,7]
	can_extend = true
