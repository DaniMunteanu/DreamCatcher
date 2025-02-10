extends FloorRoom

func _init():
	room_index = 2
	available_rooms = [0,9]
	potential_doors = [1,2,11]
	can_extend = true
	
func reset_room():
	available_rooms = [0,9]
	can_extend = true
