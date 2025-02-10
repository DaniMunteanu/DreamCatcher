extends FloorRoom

func _init():
	room_index = 4
	available_rooms = [0,13]
	potential_doors = [5,13]
	can_extend = true
	
func reset_room():
	available_rooms = [0,13]
	can_extend = true
