extends FloorRoom

func _init():
	room_index = 24
	available_rooms = [12,23,25]
	potential_doors = [32,43,44]
	can_extend = true
	
func reset_room():
	available_rooms = [12,23,25]
	can_extend = true
