extends VBoxContainer

@export var parameters: Array[UIParameter]

func _ready():
	for p in parameters:
		p.value_changed.connect(_on_parameter_changed.bind(p.parameter_name))
		p.value = Parameters.get(p.parameter_name)

func _on_parameter_changed(value: Variant, parameter_name: String):
	Parameters.set(parameter_name, value)
