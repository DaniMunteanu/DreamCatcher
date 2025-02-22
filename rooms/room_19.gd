extends FloorRoom

func _init():
	room_index = 19
	available_rooms = [7,20,30]
	potential_doors = [29,38,39]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [7,20,30]
