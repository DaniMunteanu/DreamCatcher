extends FloorRoom

func _init():
	room_index = 23
	available_rooms = [22,24]
	potential_doors = [42,43]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [22,24]
