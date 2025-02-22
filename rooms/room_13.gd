extends FloorRoom

func _init():
	room_index = 13
	available_rooms = [4,12,14,25]
	potential_doors = [13,22,23,33]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [4,12,14,25]
