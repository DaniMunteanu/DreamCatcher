class_name Tome

extends TextureRect

var damage_bonus = 0
var defense_bonus = 0
var shot_speed_bonus = 0
var fire_rate_bonus = 0
var speed_bonus = 0
var luck_bonus = 0

var position_up
var position_down

var tween = create_tween()

var tome_index = 0

var isPicked = false
	
func _init() -> void:
	z_index = 1
	
func _ready() -> void:
	position_up = position + Vector2(0,-8)
	position_down = position
	
	Global.tome_selected.connect(_on_tome_selected)
	tween.set_loops()
	tween.tween_property(self,"position",position_up,1)
	tween.tween_property(self,"position",position_down,1)
	tween.pause()
	
func _on_tome_selected(index: int):
	if index != tome_index:
		isPicked = false
		if tween:
			tween.pause()
			position = position_down
			
func hover():
	tween.play()
	isPicked = true
	Global.tome_selected.emit(tome_index)

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed and isPicked == false:
			hover()
			
