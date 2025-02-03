extends FloorRoom

func _init():
	room_index = 27
	available_rooms = [26,28]
	can_extend = true
	
func reset_room():
	available_rooms = [26,28]
	can_extend = true
