class_name PageViewMode
extends ViewMode

var page_size: int
var time_step: float

func _init(size: int, step: float):
	page_size = size
	time_step = step

func get_start_index(data: ChartData) -> int:
	var size: int = data.nodes.size()
	return size - 1 - (size - 1) % page_size

func get_delta_time(data: ChartData) -> float:
	var s := get_start_index(data)
	var e := get_end_index(data)

	var delta := data.nodes[e - 1].x - data.nodes[s].x
	var time_left := (page_size - (e - s)) * time_step
	return delta + time_left
