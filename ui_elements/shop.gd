extends Control

var tomes_res = []
var offered_tomes = []
var picked_tome_index = 0

func initialize_tomes_resorces():
	tomes_res.resize(3)
	tomes_res[0] = preload("res://tomes/TomeOfDamage.tscn")
	tomes_res[1] = preload("res://tomes/TomeOfDefense.tscn")
	tomes_res[2] = preload("res://tomes/TomeOfShotSpeed.tscn")
	
func place_tomes():
	offered_tomes.resize(3)
	offered_tomes[0] = tomes_res[0].instantiate()
	offered_tomes[1] = tomes_res[1].instantiate()
	offered_tomes[2] = tomes_res[2].instantiate()
	
	offered_tomes[0].global_position = %TomeMarker0.global_position
	offered_tomes[1].global_position = %TomeMarker1.global_position
	offered_tomes[2].global_position = %TomeMarker2.global_position
	
	offered_tomes[0].tome_index = 0
	offered_tomes[1].tome_index = 1
	offered_tomes[2].tome_index = 2
	
	add_child(offered_tomes[0])
	add_child(offered_tomes[1])
	add_child(offered_tomes[2])

func _on_tome_selected(index: int):
	get_node("DamageBar").update(Global.player_damage, Global.player_damage + offered_tomes[index].damage_bonus)
	get_node("DefenseBar").update(Global.player_defense, Global.player_defense + offered_tomes[index].defense_bonus)
	get_node("ShotSpeedBar").update(Global.player_shot_speed, Global.player_shot_speed + offered_tomes[index].shot_speed_bonus)
	get_node("FireRateBar").update(Global.player_fire_rate, Global.player_fire_rate + offered_tomes[index].fire_rate_bonus)
	get_node("SpeedBar").update(Global.player_speed, Global.player_speed + offered_tomes[index].speed_bonus)
	get_node("LuckBar").update(Global.player_luck, Global.player_luck + offered_tomes[index].luck_bonus)

func _ready() -> void:
	Global.tome_selected.connect(_on_tome_selected)
	initialize_tomes_resorces()
	place_tomes()
	offered_tomes[0].hover()
