class_name InteractionArea

extends Area2D

@export var action_name: String = "interact"

#temporar
var can_interact = false

var interact: Callable = func():
	pass
	
func _ready() -> void:
	get_node("Label").hide()

func _on_body_entered(body: Node2D) -> void:
	get_node("Label").show()
	can_interact = true

func _on_body_exited(body: Node2D) -> void:
	get_node("Label").hide()
	can_interact = false
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") && can_interact:
		interact.call()
		get_node("Label").hide()
		can_interact = false
