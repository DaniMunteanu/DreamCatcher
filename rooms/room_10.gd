extends FloorRoom

func _init():
	room_index = 10
	available_rooms = [9,11,22]
	potential_doors = [19,20,31]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [9,11,22]
