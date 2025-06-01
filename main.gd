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
	Global.save_game.connect(_on_save_game)
	Global.load_saved_game.connect(_on_load_saved_game)
	Global.open_main_menu.connect(_on_open_main_menu)
	
	if FileAccess.file_exists("user://SavedFloor.tscn") == false:
		current_main_menu.resume_game_button.disabled = true
		
func _on_start_new_game():
	DirAccess.remove_absolute("user://SavedFloor.tscn")
	current_floor = FLOOR.instantiate()
	print("Inainte de generare: ", current_floor.get_child_count())
	
	
	
	print("Dupa generare: ", current_floor.get_child_count())
	TransitionScreen.transition_black()
	
	
	await TransitionScreen.on_transition_finished

	sub_viewport.add_child(current_floor)
	current_floor.generate_floor()
	current_floor.get_node("Player").reset_stats_and_resources()

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
	Global.unpause_game.emit()
	current_floor.get_node("Player").pause_menu.game_started = true

func _on_save_game():
	var floor_save = PackedScene.new()
	print("Inainte de packing: ", current_floor.get_child_count())
	current_floor.get_node("Player").save_player_data()
	current_floor.save_floor()
	floor_save.pack(current_floor)
	print("Dupa packing: ", current_floor.get_child_count())
	ResourceSaver.save(floor_save,"user://SavedFloor.tscn")
	Global.save_minimap.emit()
	_on_delete_current_game()
	
func _on_load_saved_game():
	var current_saved_game = ResourceLoader.load("user://SavedFloor.tscn")
	current_floor = current_saved_game.instantiate()
	
	print("Dupa load: ", current_floor.get_child_count())
	
	
	TransitionScreen.transition_black()
	
	await TransitionScreen.on_transition_finished
	
	sub_viewport.add_child(current_floor)
	current_floor.load_floor()
	
	Global.load_saved_minimap.emit()
	
	current_main_menu.queue_free()
	current_main_menu = null
	
	current_floor.get_node("Player").load_player_data()
	TransitionScreen.ready_for_fade_out.emit()
	Global.unpause_game.emit()
	current_floor.get_node("Player").pause_menu.game_started = true

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
