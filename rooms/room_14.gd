extends FloorRoom

func _init():
	room_index = 14
	available_rooms = [13,15,26]
	can_extend = true
	
func reset_room():
	available_rooms = [13,15,26]
	can_extend = true
