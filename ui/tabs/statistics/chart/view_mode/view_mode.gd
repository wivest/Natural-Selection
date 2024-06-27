class_name ViewMode

func get_start_index(_data: ChartData) -> int:
	return 0

func get_end_index(data: ChartData) -> int:
	return data.nodes.size()

func get_delta_time(data: ChartData) -> float:
	var start := data.nodes[get_start_index(data)].x
	var end := data.nodes[get_end_index(data) - 1].x
	return end - start

func get_hratio(value: float, delta: float) -> float:
	return value / delta

func get_vratio(value: float, maximum: float) -> float:
	if maximum == 0:
		return 1
	return 1 - value / maximum
