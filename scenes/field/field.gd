class_name Field
extends Node2D

@export var parameters: SimulationParameters

@onready var creature_manager: CreatureManager = $CreatureManager
@onready var spawner: Spawner = $Spawner

func _ready():
	creature_manager.parameters = parameters
	spawner.items_on_start = parameters.food_on_start
	update_food_spawner()

	ready.connect(creature_manager._on_field_ready)
	ready.connect(spawner._on_field_ready)

	parameters.changed.connect(_on_parameters_changed)

func update_food_spawner():
	spawner.spawn_rate = parameters.speed * parameters.food_spawn_rate

func _on_parameters_changed():
	update_food_spawner()
