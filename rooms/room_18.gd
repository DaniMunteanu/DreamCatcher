extends FloorRoom

func _init():
	room_index = 18
	available_rooms = [7,17,30]
	potential_doors = [16,27,28]
	can_extend = true
	
func reset_room():
	available_rooms = [7,17,30]
	can_extend = true
