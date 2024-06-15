class_name Field
extends Node2D

var _copy: PackedScene = PackedScene.new()

@onready var area: Area = $Area
@onready var creatures: Holder = $Creatures
@onready var foods: Holder = $Foods

func _ready():
	_copy.pack(self)

	for i in range(Parameters.creatures):
		create_creature(area.get_random_point(), null)

	for i in range(Parameters.food):
		spawn_food()

func _process(_delta):
	if Input.is_action_just_pressed(&"restart"):
		restart()

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

func restart():
	var f = _copy.instantiate()
	add_sibling(f)
	queue_free()

func _on_spawner_timeout():
	spawn_food()

func _on_creature_born(at_position: Vector2, genes: Genome):
	create_creature(at_position, genes)
