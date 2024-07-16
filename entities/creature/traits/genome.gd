class_name Genome
extends Resource

@export var speed: Gene
@export var view_radius: Gene
@export var hatching_time: Gene

@export var genes: Dictionary # [String, Gene] pairs

func deep_copy() -> Genome:
	var g: Genome = duplicate(true)
	for key in g.genes:
		g.genes[key] = g.genes[key].duplicate(true)
	return g

func mutate():
	speed.mutate()
	view_radius.mutate()
	hatching_time.mutate()

	for gene: Gene in genes.values():
		gene.mutate()

func divide() -> Genome:
	var g: Genome = duplicate(true)
	g.mutate()
	return g

func add(g: Genome):
	speed.value += g.speed.value
	view_radius.value += g.view_radius.value
	hatching_time.value += g.hatching_time.value

	for key: String in genes.keys():
		genes[key].value += g[key].value

func sub(g: Genome):
	speed.value -= g.speed.value
	view_radius.value -= g.view_radius.value
	hatching_time.value -= g.hatching_time.value

	for key: String in genes.keys():
		genes[key].value -= g[key].value

func div(n: int):
	speed.value /= n
	view_radius.value /= n
	hatching_time.value /= n

	for key: String in genes.keys():
		genes[key].value /= n

func zero():
	speed.value = 0
	view_radius.value = 0
	hatching_time.value = 0

	for key: String in genes.keys():
		genes[key].value = 0
