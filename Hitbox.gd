class_name Hitbox

extends Area2D

var damage: int = 1 : set = set_damage, get = get_damage

signal target_hit

func set_damage(value: int):
	damage = value

func get_damage() -> int:
	return damage
