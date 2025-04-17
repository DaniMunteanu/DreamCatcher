extends Control

@export var character: CharacterBody2D

func _ready() -> void:
	Global.loot_received.connect(_on_loot_received)
	
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
		
