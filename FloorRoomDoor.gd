class_name FloorRoomDoor

extends Node2D

var room_1 = 0
var room_2 = 0

func set_rooms(room_1_index: int, room_2_index: int):
	room_1 = room_1_index
	room_2 = room_2_index
	
func open_door():
	get_node("AnimationPlayer").play("Open")
	
func close_door():
	get_node("AnimationPlayer").play("Close")
