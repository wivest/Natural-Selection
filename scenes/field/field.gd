class_name Field
extends Node2D

@export var parameters: SimulationParameters

@onready var creature_manager: CreatureManager = $CreatureManager
@onready var creature_spawner: Spawner = $CreatureManager/Spawner
@onready var cocoon_spawner: Spawner = $CreatureManager/CocoonSpawner
@onready var food_spawner: Spawner = $FoodSpawner

func _ready():
	creature_manager.parameters = parameters
	creature_spawner.item_spawned.connect(creature_manager._on_creature_spawned)
	cocoon_spawner.item_spawned.connect(creature_manager._on_cocoon_spawned)

	creature_spawner.items_on_start = parameters.creatures_on_start
	update_creature_spawner()
	food_spawner.items_on_start = parameters.food_on_start
	update_food_spawner()

	ready.connect(creature_spawner._on_field_ready)
	ready.connect(food_spawner._on_field_ready)

	parameters.changed.connect(_on_parameters_changed)

func update_creature_spawner():
	creature_spawner.spawn_rate = parameters.speed * parameters.creatures_spawn_rate

func update_food_spawner():
	food_spawner.spawn_rate = parameters.speed * parameters.food_spawn_rate

func _on_parameters_changed():
	update_creature_spawner()
	update_food_spawner()

func _on_speed_value_changed(value: float):
	parameters.speed = value
