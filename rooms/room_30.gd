extends FloorRoom

func _init():
	room_index = 30
	available_rooms = [18,19,29]
	potential_doors = [28,37,38]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [18,19,29]
