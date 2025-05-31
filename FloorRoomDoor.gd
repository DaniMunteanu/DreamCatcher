class_name FloorRoomDoor

extends Node2D

@export var room_0 = 0
@export var room_1 = 0

func _ready() -> void:
	get_node("EnterZone0").body_entered.connect(_on_enter_zone_0_body_entered)
	get_node("EnterZone1").body_entered.connect(_on_enter_zone_1_body_entered)

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
	
func _on_enter_zone_0_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		body.global_position = %Endpoint0.global_position
		Global.room_entered.emit(room_0)

func _on_enter_zone_1_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		body.global_position = %Endpoint1.global_position
		Global.room_entered.emit(room_1)
