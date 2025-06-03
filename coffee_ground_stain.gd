extends Area2D

func _ready() -> void:
	$AnimationPlayer.play("Fade")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("apply_slow_debuff"):
		body.apply_slow_debuff()

func _on_stain_faded():
	queue_free()
