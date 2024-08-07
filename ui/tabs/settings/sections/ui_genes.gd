extends Node

func _ready():
	for gene_name in Creature.average.genes:
		add_child(create_gene(gene_name))
		
func create_gene(gene_name: String) -> HBoxContainer:
	var container: HBoxContainer = HBoxContainer.new()

	var label: Label = Label.new()
	label.text = gene_name.capitalize()
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	var factor := create_factor(gene_name)
	var default := create_default(gene_name)

	container.add_child(label)
	container.add_child(factor)
	container.add_child(default)

	return container

func create_factor(gene_name: String) -> HBoxContainer:
	var container: HBoxContainer = HBoxContainer.new()

	var label: Label = Label.new()
	var math_expr: Label = Label.new()
	var factor_m: UIFactor = UIFactor.new()
	var factor_p: UIFactor = UIFactor.new()

	label.text = "Enegry per second:"
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	math_expr.text = "* value ^"
	factor_m.gene_name = gene_name
	factor_m.property_type = UIFactor.PropertyType.MULTIPLIER
	factor_p.gene_name = gene_name
	factor_p.property_type = UIFactor.PropertyType.POWER

	container.add_child(label)
	container.add_child(factor_m)
	container.add_child(math_expr)
	container.add_child(factor_p)

	return container

func create_default(gene_name: String) -> HBoxContainer:
	var container: HBoxContainer = HBoxContainer.new()

	var label: Label = Label.new()
	var gene_default: UIGeneDefault = UIGeneDefault.new()

	label.text = "Default value:"
	gene_default.gene_name = gene_name

	container.add_child(label)
	container.add_child(gene_default)

	return container