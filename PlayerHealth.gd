extends Health

var is_invincible = false

func _ready() -> void:
	Global.health_bought.connect(_on_health_bought)
	
func _on_health_bought(health_to_buy: int):
	set_current_health(current_health + health_to_buy)
	
func _on_hurtbox_received_damage(damage: int) -> void:
	if is_invincible == false:
		super(damage)
		is_invincible = true
		$InvincibilityTimer.start(2)

func _on_invincibility_timer_timeout() -> void:
	is_invincible = false
	
func _on_health_depleted() -> void:
	get_parent().set_to_dead()
	Global.game_over.emit()
