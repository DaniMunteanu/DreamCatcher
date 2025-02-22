extends Node

var cursor_angle = 0.0

signal clear_room(room_index: int)
signal room_entered(room_index: int)

signal minimap_room_entered(room_index: int, neighbour_rooms_indices: Array)

signal floor_generated

signal player_diagonal_collision_right
signal player_diagonal_collision_left
signal player_diagonal_collision_over
