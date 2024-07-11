class_name ChartParameters
extends HBoxContainer

@export var padding: int = 2

@export var step: SpinBox
@export var view_mode: OptionButton
@export var clear: Button
@export var timer: TimerLow

func _ready():
	timer.wait_time = step.value

	step.value_changed.connect(func(v: float): timer.wait_time=v)
