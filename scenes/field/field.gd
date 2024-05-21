class_name Field
extends Node2D

@onready var creature_manager: CreatureManager = $CreatureManager
@onready var creature_spawner: Spawner = $CreatureManager/Spawner
@onready var cocoon_spawner: Spawner = $CreatureManager/CocoonSpawner
@onready var food_spawner: Spawner = $FoodSpawner

func _ready():
	creature_spawner.item_spawned.connect(creature_manager._on_creature_spawned)
	cocoon_spawner.item_spawned.connect(creature_manager._on_cocoon_spawned)

	food_spawner.parameters = Parameters.data.food_spawner
	food_spawner.update_timer()
	Parameters.data.food_spawner.changed.connect(food_spawner.update_timer)
	creature_spawner.parameters = Parameters.data.creature_spawner
	creature_spawner.update_timer()
	Parameters.data.creature_spawner.changed.connect(creature_spawner.update_timer)

	ready.connect(creature_spawner._on_field_ready)
	ready.connect(food_spawner._on_field_ready)

	Parameters.data.changed.connect(_on_parameters_changed)

func _on_parameters_changed():
	food_spawner.update_timer()
	creature_spawner.update_timer()

func _on_speed_value_changed(value: float):
	Parameters.data.speed = value
