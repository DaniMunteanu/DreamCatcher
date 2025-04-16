extends FloorRoom

func _init():
	room_index = 10
	available_rooms = [9,11,22]
	potential_doors = [19,20,31]
	can_extend = true
	
func reset_room():
	super()
	available_rooms = [9,11,22]
	
func _on_enemies_defeated() -> void:
	Global.clear_room.emit(room_index)
	
func place_enemies():
	var enemies_res = preload("res://room_enemies/Room10_0.tscn")
	var enemies = enemies_res.instantiate()
	enemies.connect("enemies_defeated",_on_enemies_defeated)
	call_deferred("add_child",enemies)
