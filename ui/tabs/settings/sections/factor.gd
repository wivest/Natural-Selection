class_name UIFactor
extends SpinBox

@export var gene_name: String
@export var property_type: String

func _init():
	allow_greater = true

func _ready():
	value = Energy.factors[gene_name].get(property_type)
	value_changed.connect(_on_value_changed)

func _on_value_changed(v: float):
	Energy.factors[gene_name].set(property_type, v)
