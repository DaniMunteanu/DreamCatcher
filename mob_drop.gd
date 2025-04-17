extends Node2D

var target_position: Vector2
#250
var speed: float = 50.0
var is_moving: bool = false

var default_coin_chance = 60
var default_feather_chance = 30
var default_quartz_chance = 10

var coin_gradient = Gradient.new()
var feather_gradient = Gradient.new()
var quartz_gradient = Gradient.new()

func set_gradients_colors():
	coin_gradient.add_point(0.0, Color(0.988, 1, 0.192, 1))
	coin_gradient.add_point(1.0, Color(0.69, 0.518, 0, 1))
	
	feather_gradient.add_point(0.0, Color(0.522, 0.416, 0.212, 1))
	feather_gradient.add_point(1.0, Color(0.38, 0.349, 0.29, 1))
	
	quartz_gradient.add_point(0.0, Color(0.855, 0.475, 0.882, 1))
	quartz_gradient.add_point(1.0, Color(0.329, 0.118, 0.349, 1))

func pick_drop():
	var rng = RandomNumberGenerator.new()
	var picked_number = rng.randi_range(1,100)
	
	#ex luck = 5
	var quartz_threshold = 100 - default_quartz_chance - Global.player_luck   #100 - 10 - 5 = 85
	var feather_threshold = quartz_threshold - default_feather_chance - Global.player_luck   #85 - 30 - 5 = 50
	
	if picked_number > quartz_threshold:
		$DropTrail.set_gradient(quartz_gradient)
		print("Quartz dropped")
	elif picked_number > feather_threshold:
		$DropTrail.set_gradient(feather_gradient)
		print("Feather dropped")
	else:
		$DropTrail.set_gradient(coin_gradient)
		print("Coin dropped")

func _ready() -> void:
	set_gradients_colors()
	pick_drop()
	is_moving = true
	print("MobDrop global position: ", global_position)

func _physics_process(delta):
	if is_moving:
		var direction = (Global.player_current_position - global_position).normalized()
		var distance = global_position.distance_to(Global.player_current_position)
		
		if distance > 2.0:
			global_position += direction * speed * delta
		else:
			global_position = Global.player_current_position
			is_moving = false
			print("Arrived at target!")
			queue_free()
		
func move_to_point():
	target_position = Global.player_current_position
	is_moving = true
