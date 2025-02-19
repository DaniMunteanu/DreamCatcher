extends FloorRoomDoor

func _on_enter_zone_0_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		Global.player_diagonal_collision_left.emit()
		Global.room_entered.emit(room_0)

func _on_enter_zone_0_body_exited(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		Global.player_diagonal_collision_over.emit()

func _on_enter_zone_1_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		Global.player_diagonal_collision_right.emit()
		Global.room_entered.emit(room_1)

func _on_enter_zone_1_body_exited(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		Global.player_diagonal_collision_over.emit()
