class_name Counter
extends Label

var getter: Getter
var padding: int = 2
var step: float = 0.5

var value: float

var _value_delta: float = 0
var _value_previous: float = 0
var _time_previous: int = 0

# func _ready():
# 	value = getter.get_value()
# 	_value_previous = value
# 	_value_delta = 0
# 	_time_previous = Time.get_ticks_msec()

func _process(_delta):
	value = getter.get_value()

	var time: int = Time.get_ticks_msec()
	if time - _time_previous > step * 1000:
		_value_delta = value - _value_previous
		_value_previous = value
		_time_previous = time

	text = "Value: %.*f Delta: %.*f" % [padding, value, padding, _value_delta]
