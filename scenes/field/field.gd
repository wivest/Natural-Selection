class_name Field
extends Node2D

@onready var area: Area = $Area
@onready var creatures: Holder = $Creatures
@onready var foods: Holder = $Foods

func _ready():
	for i in range(Parameters.data.creature_spawner.on_start):
		create_creature(area.get_random_point(), null)

	for i in range(Parameters.data.food_spawner.on_start):
		spawn_food()

func create_creature(at_position: Vector2, genes: Genome):
	var creature: Creature = creatures.create(at_position)
	if genes != null:
		creature.genome = genes
	creature.born.connect(_on_creature_born)
	creatures.add(creature)

func spawn_food():
	var angle: float = randf() * 360
	var food: Food = foods.create(area.get_random_point(), angle)
	foods.add(food)

func _on_spawner_timeout():
	spawn_food()

func _on_creature_born(at_position: Vector2, genes: Genome):
	create_creature(at_position, genes)
