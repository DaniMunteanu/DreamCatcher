extends FloorRoom

func _init():
	room_index = 29
	available_rooms = [28,30]
	potential_doors = [36,37]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [28,30]
