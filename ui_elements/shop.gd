extends Control

var character: CharacterBody2D

@onready var audio_player = $AudioStreamPlayer

var tomes_res = []
var offered_tomes = []
var picked_tome_index = 0

var shop_save_file_path = "user://ShopSaveData.tres"

func save_shop():
	var shop_data = ShopSaveData.new()
	shop_data.tome_array.resize(3)
	
	for i in 3:
		var packed_tome = PackedScene.new()
		packed_tome.pack(offered_tomes[i])
		shop_data.tome_array[i] = packed_tome
		
	ResourceSaver.save(shop_data, shop_save_file_path)
	
func load_shop():
	var shop_data = ResourceLoader.load(shop_save_file_path) as ShopSaveData
	
	offered_tomes.resize(3)
	
	for i in 3:
		offered_tomes[i] = shop_data.tome_array[i].instantiate()
		add_child(offered_tomes[i])

func initialize_tomes_resorces():
	tomes_res.resize(5)
	tomes_res[0] = preload("res://tomes/TomeOfDamage.tscn")
	tomes_res[1] = preload("res://tomes/TomeOfDefense.tscn")
	tomes_res[2] = preload("res://tomes/TomeOfShotSpeed.tscn")
	tomes_res[3] = preload("res://tomes/TomeOfLuck.tscn")
	tomes_res[4] = preload("res://tomes/TomeOfFireRate.tscn")
	
func place_tomes():
	initialize_tomes_resorces()
	
	offered_tomes.resize(3)
	
	var available_tome_indexes = [0,1,2,3,4]
	for i in 3:
		var chosen_tome_index = available_tome_indexes.pick_random()
		offered_tomes[i] = tomes_res[chosen_tome_index].instantiate()
		available_tome_indexes.erase(chosen_tome_index)
	
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
	
	if offered_tomes[picked_tome_index].sold:
		$PriceLabel.text = "Sold"
		
		$BuyItemButton.disabled = true
		
		get_node("DamageBar").update(Global.player_damage, Global.player_damage)
		get_node("DefenseBar").update(Global.player_defense, Global.player_defense)
		get_node("ShotSpeedBar").update(Global.player_shot_speed, Global.player_shot_speed)
		get_node("FireRateBar").update(Global.player_fire_rate, Global.player_fire_rate)
		get_node("SpeedBar").update(Global.player_speed, Global.player_speed)
		get_node("LuckBar").update(Global.player_luck, Global.player_luck)
		
		$CoinIcon.visible = false
		$CoinAmmountForItem.text = ""
		
		$FeatherIcon.visible = false
		$FeatherAmmountForItem.text = ""
		
		$QuartzIcon.visible = false
		$QuartzAmmountForItem.text = ""
	else:
		$PriceLabel.text = "Price"
		
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
	#place_tomes()
	
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
	audio_player.play()
	
	offered_tomes[picked_tome_index].sold = true
	
	Global.player_damage = Global.player_damage + offered_tomes[picked_tome_index].damage_bonus
	Global.player_defense = Global.player_defense + offered_tomes[picked_tome_index].defense_bonus
	Global.player_shot_speed = Global.player_shot_speed + offered_tomes[picked_tome_index].shot_speed_bonus
	Global.player_fire_rate = Global.player_fire_rate + offered_tomes[picked_tome_index].fire_rate_bonus
	Global.player_speed = Global.player_speed + offered_tomes[picked_tome_index].speed_bonus
	Global.player_luck = Global.player_luck + offered_tomes[picked_tome_index].luck_bonus
	
	Global.loot_spent.emit(Global.loot_types.COIN, offered_tomes[picked_tome_index].coin_cost)
	Global.loot_spent.emit(Global.loot_types.FEATHER, offered_tomes[picked_tome_index].feather_cost)
	Global.loot_spent.emit(Global.loot_types.QUARTZ, offered_tomes[picked_tome_index].quartz_cost)
	
	Global.check_funds.emit()
	
	update()

func update():
	offered_tomes[picked_tome_index].hover()
