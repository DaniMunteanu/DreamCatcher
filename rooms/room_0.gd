extends FloorRoom

func _init():
	room_index = 0
	available_rooms = [1,2,3,4,5,6]
	can_extend = true

func reset_room():
	available_rooms = [1,2,3,4,5,6]
	can_extend = true
