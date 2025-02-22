extends FloorRoom

func _init():
	room_index = 21
	available_rooms = [20,22]
	potential_doors = [40,41]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [20,22]
