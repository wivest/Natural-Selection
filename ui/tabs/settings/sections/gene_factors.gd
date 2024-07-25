extends Node

func _ready():
	get_parent().ready.connect(add_factors)

func add_factors():
	for gene_name in Creature.average.genes:
		var factor_m: UIFactor = UIFactor.new()
		var factor_p: UIFactor = UIFactor.new()
		factor_m.gene_name = gene_name
		factor_m.property_type = UIFactor.PropertyType.MULTIPLIER
		factor_p.gene_name = gene_name
		factor_p.property_type = UIFactor.PropertyType.POWER

		add_child(factor_m, true)
		add_child(factor_p, true)
