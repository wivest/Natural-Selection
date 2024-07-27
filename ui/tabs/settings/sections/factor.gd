class_name UIFactor
extends SpinBox

enum PropertyType {
	MULTIPLIER,
	POWER,
}

@export var gene_name: String
@export var property_type: PropertyType

var _property_name: String:
	get:
		match property_type:
			PropertyType.MULTIPLIER:
				return "multiplier"
			PropertyType.POWER:
				return "power"
		return ""

func _init():
	allow_greater = true
	step = 0.05

func _ready():
	value = Energy.factors[gene_name].get(_property_name)
	value_changed.connect(_on_value_changed)

func _on_value_changed(v: float):
	Energy.factors[gene_name].set(_property_name, v)
