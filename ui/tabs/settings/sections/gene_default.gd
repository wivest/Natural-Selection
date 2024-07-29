class_name GeneDefault
extends SpinBox

func _init():
	allow_greater = true
	step = 0.1

func _ready():
	value_changed.connect(_on_value_changed)

func _on_value_changed(v: float):
	pass
