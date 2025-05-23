extends Line2D

#50
var max_points: int = 450
var queue: Array

func _process(delta: float) -> void:
	var pos = get_parent().global_position
	
	queue.push_front(pos)
	
	if queue.size() > max_points:
		queue.pop_back()
	
	clear_points()
	
	for point in queue:
		add_point(point)
