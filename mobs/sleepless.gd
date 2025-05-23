class_name Enemy

extends CharacterBody2D

@export var damage: int
@onready var hurt_animation_player = $HurtAnimationPlayer

func _ready() -> void:
	$MobHealthBar.max_value = $Health.max_health
	$MobHealthBar.value = $Health.current_health
	
	$MobHealthBar/MobSecondaryHealthBar.max_value = $Health.max_health
	$MobHealthBar/MobSecondaryHealthBar.value = $Health.current_health
	
	$Health.health_changed.connect(_update_bar)

func _update_bar(diff: int):
	$MobHealthBar.value = $Health.current_health
	
	await get_tree().create_timer(0.5).timeout
	$MobHealthBar/MobSecondaryHealthBar.value = $Health.current_health

func _on_health_health_depleted() -> void:
	Global.enemy_dead.emit(global_position)
	queue_free()
	
func _on_hitbox_area_entered(hurtbox: Hurtbox):
	if hurtbox != null:
		hurtbox.take_damage(damage - Global.player_defense)
