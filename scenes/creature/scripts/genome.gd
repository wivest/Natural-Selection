class_name Genome extends Resource

@export var speed: Gene
@export var view_radius: Gene

func mutate():
	speed.mutate()
	view_radius.mutate()
