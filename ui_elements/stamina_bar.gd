extends TextureProgressBar

@onready var timer: Timer = get_parent().character.get_node("EvadeTimer")

var staminaTexture = load("res://Sprites/SpritesUI/StaminaBar.png")
var chargedStaminaTexture = load("res://Sprites/SpritesUI/StaminaBarCharged.png")

func _process(delta: float) -> void:
	max_value = timer.wait_time
	value = timer.wait_time - timer.time_left
	
	if value == max_value:
		texture_progress = chargedStaminaTexture
	else:
		texture_progress = staminaTexture
	
