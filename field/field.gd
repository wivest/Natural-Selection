class_name Field
extends Node2D

@onready var area: Area = $Area
@onready var creatures: Holder = $Creatures
@onready var foods: Holder = $Foods
@onready var spawner: Spawner = $Spawner

func _ready():
	generate_items()

func _process(_delta):
	if Input.is_action_just_pressed(&"restart"):
		restart()

func generate_items():
	for i in range(Parameters.creatures):
		create_creature(area.get_random_point(), null)

	for i in range(Parameters.food):
		spawn_food()

func create_creature(at_position: Vector2, g: Genome):
	var creature: Creature = creatures.create(at_position)
	if g != null:
		creature.genome = g
	else:
		creature.genome = creature.genome.deep_copy()
	creature.born.connect(_on_creature_born)
	creatures.add(creature)

func spawn_food():
	var angle: float = randf() * 360
	var food: Food = foods.create(area.get_random_point(), angle)
	foods.add(food)

func restart():
	creatures.free_children()
	foods.free_children()
	spawner.start()
	generate_items()

func _on_spawner_timeout():
	spawn_food()

func _on_creature_born(at_position: Vector2, genes: Genome):
	create_creature(at_position, genes)
