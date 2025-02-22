extends FloorRoom

func _init():
	room_index = 0
	available_rooms = [1,2,3,4,5,6]
	potential_doors = [0,1,2,3,4,5,6,7,8,9]
	can_extend = true

func reset_room():
	super()
	available_rooms = [1,2,3,4,5,6]
