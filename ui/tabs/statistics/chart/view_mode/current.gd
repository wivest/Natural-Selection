class_name CurrentViewMode
extends ViewMode

var limit: int

func _init(size: int):
	limit = size

func get_start_index(data: Array) -> int:
	return max(data.size() - limit, 0)
