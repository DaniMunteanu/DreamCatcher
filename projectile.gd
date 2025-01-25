extends Area2D

var speed = 400

var direction = Vector2()

func _physics_process(delta):
	global_position += direction * speed * delta
