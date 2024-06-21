extends Label

@export var step: float = 0.5

var count: int

var _count_delta: int
var _count_previous: int
var _time_previous: int

func _ready():
	count = Creature.count
	_count_previous = count
	_count_delta = 0
	_time_previous = Time.get_ticks_msec()

func _process(_delta):
	count = Creature.count

	var time: int = Time.get_ticks_msec()
	if time - _time_previous > step * 1000:
		_count_delta = count - _count_previous
		_count_previous = count
		_time_previous = time

	text = "Count: %d Delta: %d" % [count, _count_delta]
