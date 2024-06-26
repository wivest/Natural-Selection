class_name ChartData

var nodes: Array[Vector2]

func local_max(start: int, end: int) -> float:
	var maximum: float = nodes[start].y
	for i in range(start, end):
		maximum = max(maximum, nodes[i].y)
	return maximum
