extends FloorRoom

func _init():
	room_index = 29
	available_rooms = [28,30]
	can_extend = true
	
func reset_room():
	available_rooms = [28,30]
	can_extend = true
