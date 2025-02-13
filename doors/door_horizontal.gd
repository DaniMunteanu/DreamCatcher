extends FloorRoomDoor

func _on_enter_zone_1_body_entered(player: CharacterBody2D) -> void:
	if player != null:
		player.global_position = %Endpoint1.global_position

func _on_enter_zone_2_body_entered(player: CharacterBody2D) -> void:
	if player != null:
		player.global_position = %Endpoint2.global_position
