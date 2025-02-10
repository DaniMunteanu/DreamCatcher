extends FloorRoom

func _init():
	room_index = 20
	available_rooms = [8,19,21]
	potential_doors = [30,39,40]
	can_extend = true
	
func reset_room():
	available_rooms = [8,19,21]
	can_extend = true
