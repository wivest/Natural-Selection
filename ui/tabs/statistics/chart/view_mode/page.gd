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

func get_hratio(value: float, _delta: float) -> float:
	return value / (page_size * time_step)
