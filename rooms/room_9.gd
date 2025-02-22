extends FloorRoom

func _init():
	room_index = 9
	available_rooms = [2,8,10]
	potential_doors = [11,18,19]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [2,8,10]
