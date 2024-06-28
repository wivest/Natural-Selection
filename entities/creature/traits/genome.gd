class_name Genome
extends Resource

@export var speed: Gene
@export var view_radius: Gene
@export var hatching_time: Gene

func mutate():
	speed.mutate()
	view_radius.mutate()
	hatching_time.mutate()

func divide() -> Genome:
	var g: Genome = duplicate(true)
	g.mutate()
	return g

func add(g: Genome):
	speed.value += g.speed.value
	view_radius.value += g.view_radius.value
	hatching_time.value += g.hatching_time.value

func sub(g: Genome):
	speed.value -= g.speed.value
	view_radius.value -= g.view_radius.value
	hatching_time.value -= g.hatching_time.value

func div(n: int):
	speed.value /= n
	view_radius.value /= n
	hatching_time.value /= n

func zero():
	speed.value = 0
	view_radius.value = 0
	hatching_time.value = 0
