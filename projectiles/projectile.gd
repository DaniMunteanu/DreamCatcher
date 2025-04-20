extends Area2D

#400
#speed = speed_multiplier * Global.player_shot_speed
var speed_multiplier = 30

var direction = Vector2()

func _physics_process(delta):
	global_position += direction * delta * (speed_multiplier * Global.player_shot_speed)
	
func _on_hitbox_area_entered(hurtbox: Hurtbox):
	if hurtbox != null:
		hurtbox.take_damage(Global.player_damage)
		queue_free()
		
func _on_hitbox_body_entered(body: Node2D) -> void:
	queue_free()
