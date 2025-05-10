extends Node2D

var target_position: Vector2

var speed: float = 250.0
var is_moving: bool = false

var default_coin_chance = 60
var default_feather_chance = 30
var default_quartz_chance = 10

var picked_loot_type = Global.loot_types
var picked_loot_ammount = 0

var coin_color = Color(0.988, 1, 0.192, 1)
var feather_color = Color(0.271, 0.196, 0.055)
var quartz_color = Color(0.855, 0.475, 0.882, 1)

func pick_drop():
	var rng = RandomNumberGenerator.new()
	var picked_number = rng.randi_range(1,100)
	
	#ex luck = 5
	var quartz_threshold = 100 - default_quartz_chance - Global.player_luck   #100 - 10 - 5 = 85
	var feather_threshold = quartz_threshold - default_feather_chance - Global.player_luck   #85 - 30 - 5 = 50
	
	if picked_number > quartz_threshold:
		$DropTrail.default_color = quartz_color
		picked_loot_type = Global.loot_types.QUARTZ
		picked_loot_ammount = 1
	elif picked_number > feather_threshold:
		$DropTrail.default_color = feather_color
		picked_loot_type = Global.loot_types.FEATHER
		picked_loot_ammount = rng.randi_range(10,20)
	else:
		$DropTrail.default_color = coin_color
		picked_loot_type = Global.loot_types.COIN
		picked_loot_ammount = rng.randi_range(20,50)

func _ready() -> void:
	pick_drop()
	is_moving = true

func _physics_process(delta):
	if is_moving:
		var direction = (Global.player_current_position - global_position).normalized()
		var distance = global_position.distance_to(Global.player_current_position)
		
		if distance > 2.0:
			global_position += direction * speed * delta
		else:
			global_position = Global.player_current_position
			is_moving = false
			Global.loot_received.emit(picked_loot_type, picked_loot_ammount)
			queue_free()
		
func move_to_point():
	target_position = Global.player_current_position
	is_moving = true
