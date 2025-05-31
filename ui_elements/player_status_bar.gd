extends Control

@export var character: CharacterBody2D

func refresh():
	$CoinAmount.text = str(Global.player_coins)
	$FeatherAmount.text = str(Global.player_feathers)
	$QuartzAmount.text = str(Global.player_quartz)

func _ready() -> void:
	Global.loot_received.connect(_on_loot_received)
	Global.loot_spent.connect(_on_loot_spent)
	refresh()
	
func _on_loot_received(loot_type: Global.loot_types, loot_ammount: int):
	match loot_type:
		Global.loot_types.COIN:
			Global.player_coins = clampi(Global.player_coins + loot_ammount,0,999)
			$CoinAmount.text = str(Global.player_coins)
		Global.loot_types.FEATHER:
			Global.player_feathers = clampi(Global.player_feathers + loot_ammount,0,999)
			$FeatherAmount.text = str(Global.player_feathers)
		Global.loot_types.QUARTZ:
			Global.player_quartz = clampi(Global.player_quartz + loot_ammount,0,999)
			$QuartzAmount.text = str(Global.player_quartz)
			
func _on_loot_spent(loot_type: Global.loot_types, ammount: int):
	match loot_type:
		Global.loot_types.COIN:
			Global.player_coins = Global.player_coins - ammount
			$CoinAmount.text = str(Global.player_coins)
		Global.loot_types.FEATHER:
			Global.player_feathers = Global.player_feathers - ammount
			$FeatherAmount.text = str(Global.player_feathers)
		Global.loot_types.QUARTZ:
			Global.player_quartz = Global.player_quartz - ammount
			$QuartzAmount.text = str(Global.player_quartz)
		
