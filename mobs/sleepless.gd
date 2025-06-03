class_name Enemy

extends CharacterBody2D

@onready var COFFEE_STAIN = preload("res://CoffeeGroundStain.tscn")

@export var damage: int
@onready var hurt_animation_player = $HurtAnimationPlayer
@onready var movement_animation_player = $AnimationPlayer
@onready var health = $Health

@export var speed = 50

func _ready() -> void:
	$MobHealthBar.max_value = health.max_health
	$MobHealthBar.value = health.current_health
	
	$MobHealthBar/MobSecondaryHealthBar.max_value = health.max_health
	$MobHealthBar/MobSecondaryHealthBar.value = health.current_health
	
	health.health_changed.connect(_update_bar)

func update_movement():
	var direction = global_position.direction_to(Global.player_current_position).normalized()
	if global_position.distance_to(Global.player_current_position) < 2.0:
		velocity = Vector2.ZERO
	else:
		velocity = direction * speed
	move_and_slide()
	
	var moving_angle = rad_to_deg(global_position.angle_to_point(Global.player_current_position))
	if moving_angle < 0.0:
		moving_angle += 360.0
		
	match floor(moving_angle/45.0):
		5.0, 6.0:
			movement_animation_player.play("WalkingUp")
		3.0, 4.0:
			movement_animation_player.play("WalkingLeft")
		1.0, 2.0:
			movement_animation_player.play("WalkingDown")
		0.0, 7.0:
			movement_animation_player.play("WalkingRight")

func _process(delta: float) -> void:
	update_movement()

func spawn_coffee_stain():
	var coffee_stain_instance = COFFEE_STAIN.instantiate()
	
	#coffee_stain_instance.global_position = global_position
	#Spawn in room, not enemy or room_enemies
	var room_node = get_parent().get_parent()
	var relative_spawn_global_position = $CoffeeStainSpawnPoint.global_position - room_node.global_position
	
	coffee_stain_instance.global_position = relative_spawn_global_position
	
	room_node.add_child(coffee_stain_instance)
	coffee_stain_instance.set_owner(room_node)

func _update_bar(diff: int):
	$MobHealthBar.value = health.current_health
	
	await get_tree().create_timer(0.5).timeout
	$MobHealthBar/MobSecondaryHealthBar.value = health.current_health

func _on_health_health_depleted() -> void:
	Global.enemy_dead.emit(global_position)
	queue_free()
	
func _on_hitbox_area_entered(hurtbox: Hurtbox):
	if hurtbox != null:
		hurtbox.take_damage(damage - Global.player_defense)
