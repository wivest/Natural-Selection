class_name CreatureManager
extends Node

@onready var creature_spawner: SpawnerDepr = $Spawner
@onready var cocoon_spawner: SpawnerDepr = $CocoonSpawner

func _instantiate_creature(creature_position: Vector2, genome: Genome):
	var creature := creature_spawner.spawn_item(creature_position) as Creature
	creature.genome = genome # set genome to genome of cocoon

	creature_spawner.container.add_child(creature)

func _instantiate_cocoon(cocoon_position: Vector2, genome: Genome):
	var cocoon := cocoon_spawner.spawn_item(cocoon_position) as Egg
	cocoon.genome = genome # set genome to genome of creature

	cocoon_spawner.container.add_child(cocoon)

func _on_creature_divided(creature_position: Vector2, genome: Genome):
	_instantiate_cocoon(creature_position, genome)

func _on_cocoon_incubated(cocoon_position: Vector2, genome: Genome):
	_instantiate_creature(cocoon_position, genome)

func _on_creature_spawned(item: Node):
	var creature := item as Creature
	creature.divided.connect(_on_creature_divided)

func _on_cocoon_spawned(item: Node):
	var cocoon := item as Egg
	cocoon.hatched.connect(_on_cocoon_incubated)
