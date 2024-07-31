class_name UIGeneDefault
extends SpinBox

@export var creature_scene: PackedScene = preload("res://entities/creature/creature.tscn")
@export var gene_name: String

func _init():
	allow_greater = true
	step = 0.1

func _ready():
	var instance: Creature = creature_scene.instantiate()
	value = instance.genome.genes[gene_name].value
	value_changed.connect(_on_value_changed)

func _on_value_changed(v: float):
	var instance: Creature = creature_scene.instantiate()
	instance.genome.genes[gene_name].value = v
	creature_scene.pack(instance)
