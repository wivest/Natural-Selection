class_name SliderLabel
extends Control

@export var height_offset: float = 20
@export var slider: Slider

@onready var label: Label = $Label

func _ready():
	offset_top = -height_offset
	offset_bottom = -height_offset
	_on_value_changed(slider.value)

func _on_value_changed(value: float):
	label.text = str(snapped(value, 0.1))
	anchor_left = slider.ratio
	anchor_right = slider.ratio
