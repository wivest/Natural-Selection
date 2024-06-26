class_name CurrentViewMode
extends ViewMode

var limit: int

func _init(size: int):
	limit = size

func get_start_index(data: ChartData) -> int:
	return max(data.nodes.size() - limit, 0)
