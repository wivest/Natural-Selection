class_name Counter
extends Label

var padding: int = 2

var value: float = 0:
	set(v):
		_delta = v - value
		value = v
		_update_text()

var _delta: float = 0

func _update_text():
	text = "%.*f %+.*f" % [padding, value, padding, _delta]
