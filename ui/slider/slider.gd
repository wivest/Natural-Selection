extends HSlider

@export var label_offset: float = 20

@onready var label: Label = $Value

func _ready():
	label.offset_top = -label_offset
	label.offset_bottom = -label_offset
	update_label(value)

func update_label(v: float):
	label.text = str(v)
	label.anchor_left = ratio
	label.anchor_right = ratio

func _on_value_changed(v: float):
	Parameters.speed = v
	update_label(v)
