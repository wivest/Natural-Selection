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
	var math_expr1: Label = Label.new()
	var math_expr2: Label = Label.new()
	var factor_m: UIFactor = UIFactor.new()
	var factor_p: UIFactor = UIFactor.new()
	var gene_value: SpinBox = SpinBox.new()

	factor_name.text = gene_name.capitalize()
	factor_name.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	math_expr1.text = "*"
	math_expr2.text = "^"
	factor_m.gene_name = gene_name
	factor_m.property_type = UIFactor.PropertyType.MULTIPLIER
	factor_p.gene_name = gene_name
	factor_p.property_type = UIFactor.PropertyType.POWER
	gene_value.value = Creature.average.genes[gene_name].value

	container.add_child(factor_name)
	container.add_child(factor_m)
	container.add_child(math_expr1)
	container.add_child(gene_value)
	container.add_child(math_expr2)
	container.add_child(factor_p)

	return container
