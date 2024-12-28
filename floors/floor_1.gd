extends Node2D

const ROOM_W3 = preload("res://rooms/Floor1_W3.tscn")
const ROOM_W2 = preload("res://rooms/Floor1_W2.tscn")
const ROOM_WN2 = preload("res://rooms/Floor1_WN2.tscn")

func _ready():
	generateRooms()
	
func generateRooms():
	var room_w3 = ROOM_W3.instantiate()
	room_w3.global_position = %MarkerW3.global_position
	add_child(room_w3)
	
	var room_w2 = ROOM_W2.instantiate()
	room_w2.global_position = %MarkerW2.global_position
	add_child(room_w2)
	
	var room_wn2 = ROOM_WN2.instantiate()
	room_wn2.global_position = %MarkerWN2.global_position
	add_child(room_wn2)

	
	
