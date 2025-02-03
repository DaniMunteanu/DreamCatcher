extends FloorRoom

func _init():
	room_index = 12
	available_rooms = [11,13,24]
	can_extend = true
	
func reset_room():
	available_rooms = [11,13,24]
	can_extend = true
