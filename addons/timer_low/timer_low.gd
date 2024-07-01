class_name TimerLow
extends Node

signal timeout

@export var wait_time: float = 1
@export var one_shot: bool = false
@export var autostart: bool = false

var paused: bool = false
var time_left: float:
	get:
		return _rest

var _rest: float = 0
var _stopped: bool = true

func _ready():
	_stopped = not autostart
	_rest = 0

func _process(delta):
	if paused or _stopped:
		return
	
	delta += _rest
	var timeouts: int = delta / wait_time
	_process_timeouts(timeouts)
	_rest = delta - timeouts * wait_time

func start(time_sec: float=- 1):
	_stopped = false
	_rest = 0
	if time_sec > 0:
		wait_time = time_sec

func stop():
	_stopped = true

func is_stopped() -> bool:
	return _stopped

func _process_timeouts(timeouts: int):
	if timeouts != 0:
		if one_shot:
			timeout.emit()
			_stopped = true
			return
		for i in range(timeouts):
			timeout.emit()
