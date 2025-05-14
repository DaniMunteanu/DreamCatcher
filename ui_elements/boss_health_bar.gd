extends Control

var boss_health = Health

func _ready() -> void:
	$PrimaryHealthBar.max_value = boss_health.max_health
	$PrimaryHealthBar.value = boss_health.current_health
	
	$PrimaryHealthBar/SecondaryHealthBar.max_value = boss_health.max_health
	$PrimaryHealthBar/SecondaryHealthBar.value = boss_health.current_health
	
	boss_health.health_changed.connect(_update_bar)

func _update_bar(diff: int):
	$PrimaryHealthBar.value = boss_health.current_health
	
	await get_tree().create_timer(0.5).timeout
	$PrimaryHealthBar/SecondaryHealthBar.value = boss_health.current_health
