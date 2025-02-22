extends FloorRoom

func _init():
	room_index = 14
	available_rooms = [13,15,26]
	potential_doors = [23,24,34]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [13,15,26]
