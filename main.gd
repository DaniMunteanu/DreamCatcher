extends Node2D

@onready var sub_viewport = get_node("CanvasLayer/SubViewportContainer/SubViewport")
@onready var FLOOR = preload("res://floors/Floor.tscn")
@onready var MAIN_MENU = get_node("CanvasLayer/MainMenu")

func _ready() -> void:
	Global.create_new_game.connect(_on_start_new_game)
		
func _on_start_new_game():
	var new_floor = FLOOR.instantiate()
	sub_viewport.add_child(new_floor)
	TransitionScreen.transition_black()
	await TransitionScreen.on_transition_finished
	$CanvasLayer.remove_child(MAIN_MENU)
	TransitionScreen.ready_for_fade_out.emit()
