extends FloorRoom

func _init():
	room_index = 1
	available_rooms = [0,7]
	potential_doors = [0,10]
	can_extend = true
	
func reset_room():
	available_rooms = [0,7]
	can_extend = true

func _on_room_1_0_enemies_defeated() -> void:
	Global.clear_room.emit(room_index)
