class_name Hurtbox

extends Area2D

signal received_damage(damage: int)

@export var health: Health

func take_damage(damage: int):
	print("Hit registered: Damage taken: ", damage)
	received_damage.emit(damage)
