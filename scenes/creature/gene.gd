class_name Gene extends Resource

@export var value: float = 1
@export var mutation_range: float = 0.1

func mutate():
	var mutation: float = randf_range( - mutation_range, mutation_range)
	value += mutation
