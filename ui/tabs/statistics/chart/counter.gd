extends Label

@export var getter: Getter
@export var step: float = 0.5

var value: float

var _value_delta: float
var _value_previous: float
var _time_previous: int

func _ready():
	value = getter.get_value()
	_value_previous = value
	_value_delta = 0
	_time_previous = Time.get_ticks_msec()

func _process(_delta):
	value = getter.get_value()

	var time: int = Time.get_ticks_msec()
	if time - _time_previous > step * 1000:
		_value_delta = value - _value_previous
		_value_previous = value
		_time_previous = time

	text = "Count: %d Delta: %d" % [value, _value_delta]
