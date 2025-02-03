extends FloorRoom

func _init():
	room_index = 11
	available_rooms = [3,10,12]
	can_extend = true
	
func reset_room():
	available_rooms = [3,10,12]
	can_extend = true
