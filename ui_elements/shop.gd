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

func _ready() -> void:
	initialize_tomes_resorces()
	place_tomes()
	offered_tomes[0].hover()
	
