extends Area2D

var direction = Vector2()
var bullet_speed = 100

var end_point = Vector2()

func _ready() -> void:
	$AnimationPlayer.play("Fired")

func _physics_process(delta):
	global_position += direction * delta * bullet_speed
	
	if position.distance_to(end_point) < 1.0:
		queue_free()
