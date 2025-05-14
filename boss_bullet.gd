extends Area2D

var direction = Vector2()
var bullet_speed = 100

var end_point = Vector2()

@export var damage: int

func _ready() -> void:
	$AnimationPlayer.play("Fired")

func _physics_process(delta):
	position += direction * delta * bullet_speed
	
	if position.distance_to(end_point) < 1.0:
		queue_free()

func _on_hitbox_area_entered(hurtbox: Hurtbox):
	if hurtbox != null:
		hurtbox.take_damage(damage - Global.player_defense)
