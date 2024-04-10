class_name Genome extends Resource

@export var speed: Gene
@export var view_radius: Gene
@export var incubation_time: Gene

func mutate():
	speed.mutate()
	view_radius.mutate()
	incubation_time.mutate()
