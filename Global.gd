extends Node

var cursor_angle = 0.0

var player_damage = 5
var player_defense = 5
var player_shot_speed = 5
var player_fire_rate = 5
var player_speed = 5
var player_luck = 5

signal clear_room(room_index: int)
signal room_entered(room_index: int)

signal minimap_room_entered(room_index: int, neighbour_rooms_indices: Array)

signal floor_generated

signal player_diagonal_collision_right
signal player_diagonal_collision_left
signal player_diagonal_collision_over

signal open_shop
signal close_shop

signal tome_selected(tome_index: int)

signal buy_health_hover(health_to_buy: int)
signal buy_health_hover_end
