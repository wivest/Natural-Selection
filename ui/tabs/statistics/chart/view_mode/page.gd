class_name PageViewMode
extends ViewMode

var page_size: int

func _init(size: int):
	page_size = size

func get_start_index(data: ChartData) -> int:
	var size: int = data.nodes.size()
	return size - 1 - (size - 1) % page_size
