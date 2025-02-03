extends FloorRoom

func _init():
	room_index = 30
	available_rooms = [18,19,29]
	can_extend = true
	
func reset_room():
	available_rooms = [18,19,29]
	can_extend = true
