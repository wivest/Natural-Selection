class_name UIParameter
extends SpinBox

@export var parameter_name: String

func _init():
	allow_greater = true
	step = 0.1

func _ready():
	value = Parameters.get(parameter_name)
	value_changed.connect(_on_value_changed)

func _on_value_changed(v: float):
	Parameters.set(parameter_name, v)
