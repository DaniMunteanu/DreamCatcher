extends TextureProgressBar

@onready var timer: Timer = get_parent().character.get_node("EvadeTimer")

var stamina_texture = load("res://Sprites/SpritesUI/StaminaBar.png")
var charged_stamina_texture = load("res://Sprites/SpritesUI/StaminaBarCharged.png")

func _process(delta: float) -> void:
	max_value = timer.wait_time
	value = timer.wait_time - timer.time_left
	
	if value == max_value:
		texture_progress = charged_stamina_texture
	else:
		texture_progress = stamina_texture
	
