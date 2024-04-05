class_name Gene extends Resource

@export var value: float = 20

var mutation_range: float = 1

func mutate():
	value += mutation_range
