extends FloorRoom

func _init():
	room_index = 28
	available_rooms = [16,27,29]
	potential_doors = [35,36,47]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [26,27,29]
