class_name Genome
extends Resource

@export var genes: Dictionary # [String, Gene] pairs

func deep_copy() -> Genome:
	var g: Genome = duplicate(true)
	for key in g.genes:
		g.genes[key] = g.genes[key].duplicate(true)
	return g

func mutate():
	for gene: Gene in genes.values():
		gene.mutate()

func divide() -> Genome:
	var g: Genome = duplicate(true)
	g.mutate()
	return g

func add(g: Genome):
	for key: String in genes:
		genes[key].value += g.genes[key].value

func sub(g: Genome):
	for key: String in genes:
		genes[key].value -= g.genes[key].value

func div(n: int):
	for key: String in genes:
		genes[key].value /= n

func zero():
	for key: String in genes:
		genes[key].value = 0
