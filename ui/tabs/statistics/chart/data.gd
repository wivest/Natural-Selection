class_name ChartData

var nodes: Array[Vector2]

func local_min(start: int, end: int) -> float:
	var minimum: float = nodes[start].y
	for i in range(start, end):
		minimum = min(minimum, nodes[i].y)
	return minimum

func local_max(start: int, end: int) -> float:
	var maximum: float = nodes[start].y
	for i in range(start, end):
		maximum = max(maximum, nodes[i].y)
	return maximum

func get_delta_time(start: int, end: int) -> float:
	return nodes[end].x - nodes[start].x

func get_relative_time(i: int, relative_to: int) -> float:
	return nodes[i].x - nodes[relative_to].x
