class_name InteractionArea

extends Area2D

@export var action_name: String = "interact"
@export var label_text: String

@onready var label = $Label

#temporar
var can_interact = false

var interact: Callable = func():
	pass
	
func _ready() -> void:
	label.hide()
	label.text = label_text

func _on_body_entered(body: Node2D) -> void:
	label.show()
	can_interact = true

func _on_body_exited(body: Node2D) -> void:
	label.hide()
	can_interact = false
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && can_interact:
		interact.call()
		label.hide()
		can_interact = false
