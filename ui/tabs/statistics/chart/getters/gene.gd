class_name GeneGetter
extends Getter

@export var gene_name: String

func get_value() -> float:
	return Creature.average.genes[gene_name].value
