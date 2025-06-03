extends TextureProgressBar

@onready var player = get_parent().character
@onready var timer: Timer = get_parent().character.get_node("EvadeTimer")

var stamina_texture = load("res://Sprites/SpritesUI/StaminaBar.png")
var charged_stamina_texture = load("res://Sprites/SpritesUI/StaminaBarCharged.png")
@onready var stamina_bar_blocker = $StaminaBarBlocker

var start_point = 0.0

func _process(delta: float) -> void:
	max_value = start_point + timer.wait_time
	value = start_point + timer.wait_time - timer.time_left
	
	if value == max_value:
		texture_progress = charged_stamina_texture
	else:
		texture_progress = stamina_texture
		
	stamina_bar_blocker.visible = player.evade_restricted
