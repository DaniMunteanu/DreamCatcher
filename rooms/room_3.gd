extends FloorRoom

func _init():
	room_index = 3
	available_rooms = [0,11]
	potential_doors = [3,4,12]
	can_extend = true
	
func reset_room():
	available_rooms = [0,11]
	can_extend = true
