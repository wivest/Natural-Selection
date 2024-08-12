class_name Gene
extends Resource

@export var value: float = 1
@export var mutation_range: float = 0.1

func mutate():
	var delta: float = value * mutation_range
	var mutation: float = randf_range(-delta, delta)
	value += mutation
	value = max(0, value)
