extends Node

func _ready():
	get_parent().ready.connect(add_factors)

func add_factors():
	for gene_name in Creature.average.genes:
		var factor := create_factor(gene_name)
		add_sibling(factor)

func create_factor(gene_name: String) -> HBoxContainer:
	var container: HBoxContainer = HBoxContainer.new()
	var factor_name: Label = Label.new()
	var math_expr: Label = Label.new()
	var factor_m: UIFactor = UIFactor.new()
	var factor_p: UIFactor = UIFactor.new()

	factor_name.text = gene_name.capitalize()
	math_expr.text = "* %d ^" % Creature.average.genes[gene_name].value
	factor_m.gene_name = gene_name
	factor_m.property_type = UIFactor.PropertyType.MULTIPLIER
	factor_p.gene_name = gene_name
	factor_p.property_type = UIFactor.PropertyType.POWER

	container.add_child(factor_name)
	container.add_child(factor_m)
	container.add_child(math_expr)
	container.add_child(factor_p)

	return container
