extends Node2D

func _ready() -> void:
	get_node("InteractionArea").interact = Callable(self, "open_shop")
	
func open_shop():
	BackgroundMusic.play_audio(BackgroundMusic.shop_audio)
	Global.open_shop.emit()
	Global.check_funds.emit()
