extends FloorRoom

func _init():
	room_index = 26
	available_rooms = [14,25,27]
	can_extend = true
	
func reset_room():
	available_rooms = [14,25,27]
	can_extend = true
