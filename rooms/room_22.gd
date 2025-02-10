extends FloorRoom

func _init():
	room_index = 22
	available_rooms = [10,21,23]
	potential_doors = [31,41,42]
	can_extend = true
	
func reset_room():
	available_rooms = [10,21,23]
	can_extend = true
