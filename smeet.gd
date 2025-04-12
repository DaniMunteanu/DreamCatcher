extends Node2D

func _ready() -> void:
	get_node("InteractionArea").interact = Callable(self, "open_shop")
	
func open_shop():
	Global.open_shop.emit()
