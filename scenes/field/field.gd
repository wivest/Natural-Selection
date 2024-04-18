class_name Field
extends Node2D

signal parameters_initialized(values: SimulationParameters)

@export var parameters: SimulationParameters

@onready var creature_manager: CreatureManager = $CreatureManager
@onready var spawner: Spawner = $Spawner

func _ready():
	creature_manager.parameters = parameters
	spawner.parameters = parameters

	ready.connect(creature_manager._on_field_ready)
	ready.connect(spawner._on_field_ready)
