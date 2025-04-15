extends Node2D

var target_position: Vector2
var speed: float = 250.0
var is_moving: bool = false

func _ready() -> void:
	is_moving = true
	print("MobDrop global position: ", global_position)

func _physics_process(delta):
	if is_moving:
		var direction = (Global.player_current_position - global_position).normalized()
		var distance = global_position.distance_to(Global.player_current_position)
		
		if distance > 1.0:
			global_position += direction * speed * delta
		else:
			global_position = Global.player_current_position
			is_moving = false
			print("Arrived at target!")
		
func move_to_point():
	target_position = Global.player_current_position
	is_moving = true
