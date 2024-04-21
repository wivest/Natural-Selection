class_name CreatureManager
extends Node

@export var creature_scene: PackedScene
@export var cocoon_scene: PackedScene

var parameters: SimulationParameters

@onready var container: Node = $Spawner/Container

func _instantiate_creature(creature_position: Vector2, genome: Genome):
	var creature: Creature = creature_scene.instantiate() as Creature
	creature.position = creature_position
	creature.energy = parameters.energy_on_start # set start energy
	creature.divided.connect(_on_creature_divided)

	creature.parameters = parameters # set parameters

	if genome != null:
		creature.genome = genome # set genome to genome of cocoon
	
	container.add_child(creature)

func _instantiate_cocoon(cocoon_position: Vector2, genome: Genome):
	var cocoon: Cocoon = cocoon_scene.instantiate() as Cocoon
	cocoon.position = cocoon_position
	cocoon.incubated.connect(_on_cocoon_incubated)

	cocoon.parameters = parameters # set parameters

	var mutated_genome: Genome = genome.duplicate(true) as Genome
	mutated_genome.mutate()
	cocoon.genome = mutated_genome # mutate genome of a creature
	
	container.add_child(cocoon)

func _on_creature_divided(creature_position: Vector2, genome: Genome):
	_instantiate_cocoon(creature_position, genome)

func _on_cocoon_incubated(cocoon_position: Vector2, genome: Genome):
	_instantiate_creature(cocoon_position, genome)

func _on_item_spawned(item: Node):
	var creature := item as Creature
	creature.energy = parameters.energy_on_start # set start energy
	creature.parameters = parameters
	creature.divided.connect(_on_creature_divided)
