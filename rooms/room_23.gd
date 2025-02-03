extends FloorRoom

func _init():
	room_index = 23
	available_rooms = [22,24]
	can_extend = true
	
func reset_room():
	available_rooms = [22,24]
	can_extend = true
