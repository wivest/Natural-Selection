class_name ViewMode

func get_start_index(_data: ChartData) -> int:
	return 0

func get_end_index(_data: ChartData) -> int:
	return _data.nodes.size()

func get_hratio(_value: float, _delta: float) -> float:
	return _value / _delta

func get_vratio(_value: float, _maximum: float) -> float:
	if _maximum == 0:
		return 0
	return 1 - _value / _maximum
