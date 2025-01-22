extends Area2D

var speed = 700

var mouse_location = Vector2()

func _physics_process(delta):
	var shooting_direction = mouse_location
	global_position -= shooting_direction * speed * delta
