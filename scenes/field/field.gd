class_name Field
extends Node2D

@onready var creature_manager: CreatureManager = $CreatureManager
@onready var creature_spawner: Spawner = $CreatureManager/Spawner
@onready var cocoon_spawner: Spawner = $CreatureManager/CocoonSpawner
@onready var food_spawner: Spawner = $FoodSpawner

func _ready():
	creature_spawner.item_spawned.connect(creature_manager._on_creature_spawned)
	cocoon_spawner.item_spawned.connect(creature_manager._on_cocoon_spawned)

	creature_spawner.items_on_start = Parameters.data.creatures_on_start
	update_creature_spawner()
	food_spawner.items_on_start = Parameters.data.food_on_start
	update_food_spawner()

	ready.connect(creature_spawner._on_field_ready)
	ready.connect(food_spawner._on_field_ready)

	Parameters.data.changed.connect(_on_parameters_changed)

func update_creature_spawner():
	creature_spawner.spawn_rate = Parameters.data.speed * Parameters.data.creatures_spawn_rate

func update_food_spawner():
	food_spawner.spawn_rate = Parameters.data.speed * Parameters.data.food_spawn_rate

func _on_parameters_changed():
	update_creature_spawner()
	update_food_spawner()

func _on_speed_value_changed(value: float):
	Parameters.data.speed = value

func _on_parameters_parameters_changed(p: ParametersData):
	Parameters.data = p
	_on_parameters_changed()
