extends Area2D

var speed = 400

var direction = Vector2()

func _physics_process(delta):
	global_position += direction * speed * delta
	
func _on_hitbox_area_entered(hurtbox: Hurtbox):
	if hurtbox != null:
		hurtbox.take_damage(get_node("Hitbox").damage)
		queue_free()
