extends SpinBox

@export var chart: Chart

func _ready():
	value = chart.step

func _on_value_changed(v: float):
	chart.step = v