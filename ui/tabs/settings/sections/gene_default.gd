class_name GeneDefault
extends SpinBox

@export var creature_scene: String
@export var gene_name: String

func _init():
	allow_greater = true
	step = 0.1

func _ready():
	value_changed.connect(_on_value_changed)

func _on_value_changed(v: float):
	var scene: PackedScene = load(creature_scene)
	var instance: Creature = scene.instantiate()
	instance.genome.genes[gene_name].value = v
	# pack scene into file
