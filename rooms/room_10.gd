extends FloorRoom

func _init():
	room_index = 10
	available_rooms = [9,11,22]
	can_extend = true
	
func reset_room():
	available_rooms = [9,11,22]
	can_extend = true
