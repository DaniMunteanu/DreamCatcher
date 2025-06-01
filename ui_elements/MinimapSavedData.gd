extends Resource
class_name MinimapSave

@export var rooms_visibility = []
@export var rooms_texture = []
@export var rooms_is_discovered = []
@export var shop_room_index : int

func _init() -> void:
	rooms_visibility.resize(31)
	rooms_texture.resize(31)
	rooms_is_discovered.resize(31)
