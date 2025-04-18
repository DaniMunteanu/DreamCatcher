extends FloorRoom

func _init():
	room_index = 1
	available_rooms = [0,7]
	potential_doors = [0,10]
	can_extend = true

func reset_room():
	super()
	available_rooms = [0,7]

func _on_enemies_defeated() -> void:
	Global.clear_room.emit(room_index)
	
func place_enemies():
	var enemies_res = preload("res://room_enemies/Enemies1_0.tscn")
	var enemies = enemies_res.instantiate()
	enemies.connect("enemies_defeated",_on_enemies_defeated)
	call_deferred("add_child",enemies)
