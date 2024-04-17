class_name CreatureManager
extends Area2D

signal simulation_speed_changed(new_speed: float)

@export var creature_scene: PackedScene
@export var cocoon_scene: PackedScene
@export var creatures_on_start: int = 10

var simulation_speed: float = 1

@onready var bounds: Rect2 = $Bounds.shape.get_rect()
@onready var container: Node = $Container

func _ready():
	for i in range(creatures_on_start):
		_instantiate_creature(get_random_point(), null)

func get_random_point() -> Vector2: # get random point inside bounds
	var x := randf_range(bounds.position.x, bounds.end.x)
	var y := randf_range(bounds.position.y, bounds.end.y)
	return Vector2(x, y)

func _instantiate_creature(creature_position: Vector2, genome: Genome):
	var creature: Creature = creature_scene.instantiate() as Creature
	creature.position = creature_position
	creature.divided.connect(_on_creature_divided)

	creature.simulation_speed = simulation_speed # rewrite simulation speed
	simulation_speed_changed.connect(creature._on_simulation_speed_changed)

	if genome != null:
		creature.genome = genome # set genome to genome of cocoon
	
	container.add_child(creature)

func _instantiate_cocoon(cocoon_position: Vector2, genome: Genome):
	var cocoon: Cocoon = cocoon_scene.instantiate() as Cocoon
	cocoon.position = cocoon_position
	cocoon.incubated.connect(_on_cocoon_incubated)

	cocoon.simulation_speed = simulation_speed # rewrite simulation speed
	simulation_speed_changed.connect(cocoon._on_simulation_speed_changed)

	var mutated_genome: Genome = genome.duplicate(true) as Genome
	mutated_genome.mutate()
	cocoon.genome = mutated_genome # mutate genome of a creature
	
	container.add_child(cocoon)

func _on_creature_divided(creature_position: Vector2, genome: Genome):
	_instantiate_cocoon(creature_position, genome)

func _on_cocoon_incubated(cocoon_position: Vector2, genome: Genome):
	_instantiate_creature(cocoon_position, genome)
