extends FloorRoom

func _init():
	room_index = 26
	available_rooms = [14,25,27]
	potential_doors = [34,45,46]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [14,25,27]
