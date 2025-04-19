class_name FutureProgressBar

extends TextureProgressBar

var future_value_positive_texture = load("res://Sprites/SpritesUI/FutureStatBarPositive.png")
var future_value_negative_texture = load("res://Sprites/SpritesUI/FutureStatBarNegative.png")

func update(current_value: int, future_value: int):
	if future_value > current_value:
		value = current_value
		
		get_node("FutureProgressBar").value = future_value
		get_node("FutureProgressBar").texture_progress = future_value_positive_texture
	elif future_value < current_value:
		value = future_value
		
		get_node("FutureProgressBar").value = current_value
		get_node("FutureProgressBar").texture_progress = future_value_negative_texture
	else:
		value = future_value
		get_node("FutureProgressBar").value = 0
