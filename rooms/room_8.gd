extends FloorRoom

func _init():
	room_index = 8
	available_rooms = [7,9,20]
	potential_doors = [17,18,30]
	can_extend = true
	
func reset_room():
	available_rooms = [7,9,20]
	can_extend = true
