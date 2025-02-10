class_name FloorRoomDoor

extends Node2D

func open_door():
	get_node("AnimationPlayer").play("Open")
	
func close_door():
	get_node("AnimationPlayer").play("Close")
