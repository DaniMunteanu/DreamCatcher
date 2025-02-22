extends FloorRoom

func _init():
	room_index = 16
	available_rooms = [15,17,28]
	potential_doors = [25,26,35]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [15,17,28]
