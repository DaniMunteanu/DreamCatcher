extends Line2D

#50
var max_points: int = 150
var queue: Array
@onready var curve := Curve2D.new()

#func _ready() -> void:
	#global_position = get_parent().global_position
	#print("Trail global position: ",get_parent().global_position)

func _process(delta: float) -> void:
	var pos = get_parent().global_position
	
	queue.push_front(pos)
	
	if queue.size() > max_points:
		queue.pop_back()
	
	clear_points()
	
	for point in queue:
		add_point(point)
	
	
	
	"""
	print("Trail point drawn: ",get_parent().global_position)
	curve.add_point(get_parent().global_position)
	if curve.get_baked_points().size() > max_points:
		curve.remove_point(0)
	points = curve.get_baked_points()
	"""
	
