extends FloorRoomDoor

func _on_enter_zone_1_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		Global.player_diagonal_collision_right.emit()
		print("diagonal collision detected")

func _on_enter_zone_1_body_exited(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		Global.player_diagonal_collision_left.emit()
		print("diagonal collision detected")

func _on_enter_zone_2_body_entered(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		Global.player_diagonal_collision_left.emit()
		print("diagonal collision detected")

func _on_enter_zone_2_body_exited(body: Node2D) -> void:
	if body.get_class() == "CharacterBody2D":
		Global.player_diagonal_collision_over.emit()
		print("diagonal collision over")
	
