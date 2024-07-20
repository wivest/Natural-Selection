extends Node

@export var chart_scene: PackedScene
@export var parameters: ChartParameters

func _ready():
	get_parent().ready.connect(add_charts)

func add_charts():
	for gene_name in Creature.average.genes:
		var chart: Chart = chart_scene.instantiate()
		var getter: GeneGetter = GeneGetter.new()
		getter.gene_name = gene_name

		chart.parameters = parameters
		chart.getter = getter

		add_sibling(chart)
