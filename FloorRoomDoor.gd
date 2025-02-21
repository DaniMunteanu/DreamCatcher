class_name FloorRoomDoor

extends Node2D

var room_0 = 0
var room_1 = 0

func set_rooms(room_0_index: int, room_1_index: int):
	room_0 = room_0_index
	room_1 = room_1_index
	
func open_door():
	get_node("AnimationPlayer").play("Open")
	
func close_door():
	get_node("AnimationPlayer").play("Close")
	
func _on_open_door():
	get_node("EnterZone0").set_collision_mask_value(2,true)
	get_node("EnterZone1").set_collision_mask_value(2,true)
	
func _on_close_door():
	get_node("EnterZone0").set_collision_mask_value(2,false)
	get_node("EnterZone1").set_collision_mask_value(2,false)
