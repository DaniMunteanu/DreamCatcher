extends FloorRoom

func _init():
	room_index = 7
	available_rooms = [1,8,18,19]
	potential_doors = [10,16,17,29]
	can_extend = true
	
func reset_room():
	available_rooms = [1,8,18,19]
	can_extend = true
