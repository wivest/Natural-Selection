class_name ViewMode

func get_start_index(_data: ChartData) -> int:
	return 0

func get_vratio(_value: float, _maximum: float) -> float:
	if _maximum == 0:
		return 0
	return 1 - _value / _maximum
