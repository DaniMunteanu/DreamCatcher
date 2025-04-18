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
	picked_tome_index = index
	get_node("DamageBar").update(Global.player_damage, Global.player_damage + offered_tomes[picked_tome_index].damage_bonus)
	get_node("DefenseBar").update(Global.player_defense, Global.player_defense + offered_tomes[picked_tome_index].defense_bonus)
	get_node("ShotSpeedBar").update(Global.player_shot_speed, Global.player_shot_speed + offered_tomes[picked_tome_index].shot_speed_bonus)
	get_node("FireRateBar").update(Global.player_fire_rate, Global.player_fire_rate + offered_tomes[picked_tome_index].fire_rate_bonus)
	get_node("SpeedBar").update(Global.player_speed, Global.player_speed + offered_tomes[picked_tome_index].speed_bonus)
	get_node("LuckBar").update(Global.player_luck, Global.player_luck + offered_tomes[picked_tome_index].luck_bonus)
	
	if offered_tomes[picked_tome_index].coin_cost:
		$CoinIcon.visible = true
		$CoinAmmountForItem.text = str(offered_tomes[picked_tome_index].coin_cost)
		$CoinAmmountForItem.set("theme_override_colors/font_color",Color(1, 1, 1))
	else:
		$CoinIcon.visible = false
		$CoinAmmountForItem.text = ""
		
	if offered_tomes[picked_tome_index].feather_cost:
		$FeatherIcon.visible = true
		$FeatherAmmountForItem.text = str(offered_tomes[picked_tome_index].feather_cost)
		$FeatherAmmountForItem.set("theme_override_colors/font_color",Color(1, 1, 1))
	else:
		$FeatherIcon.visible = false
		$FeatherAmmountForItem.text = ""
		
	if offered_tomes[picked_tome_index].quartz_cost:
		$QuartzIcon.visible = true
		$QuartzAmmountForItem.text = str(offered_tomes[picked_tome_index].quartz_cost)
		$QuartzAmmountForItem.set("theme_override_colors/font_color",Color(1, 1, 1))
	else:
		$QuartzIcon.visible = false
		$QuartzAmmountForItem.text = ""
		
	_on_check_funds()

func _ready() -> void:
	Global.tome_selected.connect(_on_tome_selected)
	Global.check_funds.connect(_on_check_funds)
	initialize_tomes_resorces()
	place_tomes()
	
func _on_check_funds():
	$BuyItemButton.disabled = false
	if Global.player_coins < offered_tomes[picked_tome_index].coin_cost:
		$CoinAmmountForItem.set("theme_override_colors/font_color",Color(1, 0, 0))
		$BuyItemButton.disabled = true
	if Global.player_feathers < offered_tomes[picked_tome_index].feather_cost:
		$FeatherAmmountForItem.set("theme_override_colors/font_color",Color(1, 0, 0))
		$BuyItemButton.disabled = true
	if Global.player_quartz < offered_tomes[picked_tome_index].quartz_cost:
		$QuartzAmmountForItem.set("theme_override_colors/font_color",Color(1, 0, 0))
		$BuyItemButton.disabled = true

func _on_buy_item_button_pressed() -> void:
	#Global.health_bought.emit(15)
	Global.loot_spent.emit(Global.loot_types.COIN, offered_tomes[picked_tome_index].coin_cost)
	Global.loot_spent.emit(Global.loot_types.FEATHER, offered_tomes[picked_tome_index].feather_cost)
	Global.loot_spent.emit(Global.loot_types.QUARTZ, offered_tomes[picked_tome_index].quartz_cost)
	Global.check_funds.emit()

func update():
	offered_tomes[0].hover()
