class_name Genome extends Resource

@export var speed: Gene # = preload ("res://scenes/creature/resources/gene_speed.tres")

func mutate():
	speed.mutate()
