class_name Field
extends Node2D

@export var parameters: SimulationParameters

@onready var creature_manager: CreatureManager = $CreatureManager
@onready var spawner: Spawner = $Spawner

func _ready():
	creature_manager.simulation_speed = parameters.speed
	creature_manager.simulation_speed_changed.emit(parameters.speed)
	spawner.simulation_speed = parameters.speed
