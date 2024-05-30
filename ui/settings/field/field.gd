@tool
extends HBoxContainer

signal field_changed(v: float)

@export var field_name: String:
	set(v):
		field_name = v
		if name_label != null:
			name_label.text = field_name
@export var start: float:
	set(v):
		start = v
		if value_box != null:
			value_box.value = start

@onready var name_label: Label = $Name
@onready var value_box: SpinBox = $Value

func _ready():
	name_label.text = field_name
	value_box.value = start

func _on_value_changed(v: float):
	if not Engine.is_editor_hint():
		field_changed.emit(v)
