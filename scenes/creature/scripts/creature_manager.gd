class_name CreatureManager
extends Node

@export var cocoon_scene: PackedScene

@onready var creature_spawner: Spawner = $Spawner
@onready var cocoon_spawner: Spawner = $CocoonSpawner

func _instantiate_creature(creature_position: Vector2, genome: Genome):
	var creature := creature_spawner.spawn_item() as Creature
	creature.position = creature_position
	creature.genome = genome # set genome to genome of cocoon

	creature_spawner.container.add_child(creature)

func _instantiate_cocoon(cocoon_position: Vector2, genome: Genome):
	var cocoon := cocoon_spawner.spawn_item() as Cocoon
	cocoon.position = cocoon_position

	var mutated_genome: Genome = genome.duplicate(true) as Genome
	mutated_genome.mutate()
	cocoon.genome = mutated_genome # mutate genome of a creature

	cocoon_spawner.container.add_child(cocoon)

func _on_creature_divided(creature_position: Vector2, genome: Genome):
	_instantiate_cocoon(creature_position, genome)

func _on_cocoon_incubated(cocoon_position: Vector2, genome: Genome):
	_instantiate_creature(cocoon_position, genome)

func _on_creature_spawned(item: Node):
	var creature := item as Creature
	creature.energy = Parameters.data.energy_on_start # set start energy
	creature.divided.connect(_on_creature_divided)

func _on_cocoon_spawned(item: Node):
	var cocoon := item as Cocoon
	cocoon.incubated.connect(_on_cocoon_incubated)
