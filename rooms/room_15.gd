extends FloorRoom

func _init():
	room_index = 15
	available_rooms = [5,14,16]
	potential_doors = [14,24,25]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [5,14,16]
