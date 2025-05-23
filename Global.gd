extends Node

var cursor_angle = 0.0

var player_damage = 5
var player_defense = 5
var player_shot_speed = 5
var player_fire_rate = 5
var player_speed = 5
var player_luck = 5

var player_coins = 0
var player_feathers = 0
var player_quartz = 0

var player_current_position = Vector2(0,0)

enum loot_types {COIN, FEATHER, QUARTZ}

signal clear_room(room_index: int)
signal room_entered(room_index: int)
signal enemy_dead(enemy_death_position: Vector2)

signal minimap_room_entered(room_index: int, neighbour_rooms_indices: Array)

signal floor_generated

signal loot_received(loot_type: loot_types, loot_ammount: int)

signal open_shop
signal close_shop

signal tome_selected(tome_index: int)

signal buy_health_hover(health_to_buy: int)
signal buy_health_hover_end

signal health_bought(health_to_buy: int)

signal loot_spent(loot_type: loot_types, ammount: int)
signal check_funds

signal boss_summoned
signal boss_defeated

signal create_new_game
signal delete_current_game
signal game_victory
signal game_over
signal open_main_menu
