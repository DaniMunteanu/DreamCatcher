extends FloorRoom

func _init():
	room_index = 21
	available_rooms = [20,22]
	can_extend = true
	
func reset_room():
	available_rooms = [20,22]
	can_extend = true
