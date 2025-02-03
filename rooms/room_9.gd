extends FloorRoom

func _init():
	room_index = 9
	available_rooms = [2,8,10]
	can_extend = true
	
func reset_room():
	available_rooms = [2,8,10]
	can_extend = true
