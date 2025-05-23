class_name Hurtbox

extends Area2D

signal received_damage(damage: int)

@export var health: Health

func take_damage(damage: int):
	received_damage.emit(damage)
