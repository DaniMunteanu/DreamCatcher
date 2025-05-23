extends Node2D

@onready var sub_viewport = get_node("CanvasLayer/SubViewportContainer/SubViewport")
@onready var FLOOR = preload("res://floors/Floor.tscn")
@onready var MAIN_MENU = preload("res://ui_elements/MainMenu.tscn")
@onready var VICTORY_MENU = preload("res://ui_elements/VictoryMenu.tscn")
@onready var GAME_OVER_MENU = preload("res://ui_elements/GameOverMenu.tscn")

var current_floor
var current_victory_menu
var current_main_menu
var current_game_over_menu

func _ready() -> void:
	_on_open_main_menu()
	Global.create_new_game.connect(_on_start_new_game)
	Global.delete_current_game.connect(_on_delete_current_game)
	Global.game_victory.connect(_on_game_victory)
	Global.game_over.connect(_on_game_over)
	Global.open_main_menu.connect(_on_open_main_menu)
		
func _on_start_new_game():
	current_floor = FLOOR.instantiate()
	sub_viewport.add_child(current_floor)
	TransitionScreen.transition_black()
	await TransitionScreen.on_transition_finished

	if current_main_menu != null:
		current_main_menu.queue_free()
		current_main_menu = null
	elif current_victory_menu != null:
		current_victory_menu.queue_free()
		current_victory_menu = null
	else:
		current_game_over_menu.queue_free()
		current_game_over_menu = null
	
	TransitionScreen.ready_for_fade_out.emit()

func _on_delete_current_game():
	current_floor.get_node("Player").opened_shop.queue_free()
	current_floor.queue_free()
	current_floor = null
	
func _on_game_victory():
	TransitionScreen.transition_black()
	await TransitionScreen.on_transition_finished
	_on_delete_current_game()
	current_victory_menu = VICTORY_MENU.instantiate()
	$CanvasLayer.add_child(current_victory_menu)
	TransitionScreen.ready_for_fade_out.emit()
	
func _on_game_over():
	TransitionScreen.transition_black()
	await TransitionScreen.on_transition_finished
	_on_delete_current_game()
	current_game_over_menu = GAME_OVER_MENU.instantiate()
	$CanvasLayer.add_child(current_game_over_menu)
	TransitionScreen.ready_for_fade_out.emit()
	
func _on_open_main_menu():
	current_main_menu = MAIN_MENU.instantiate()
	$CanvasLayer.add_child(current_main_menu)
