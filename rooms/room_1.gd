extends FloorRoom

func _init():
	room_index = 1
	available_rooms = [0,7]
	potential_doors = [0,10]
	can_extend = true

func reset_room():
	super()
	available_rooms = [0,7]
