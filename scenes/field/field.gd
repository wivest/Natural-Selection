extends Node2D

@export var simulation_speed: float = 1:
	set = set_simulation_speed

var _was_ready: bool = false

@onready var creature_manager: CreatureManager = $CreatureManager
@onready var spawner: Spawner = $Spawner

func _ready():
	_was_ready = true
	set_simulation_speed(simulation_speed)

func set_simulation_speed(value: float):
	simulation_speed = value
	if not _was_ready:
		return
	creature_manager.simulation_speed = value
	creature_manager.simulation_speed_changed.emit(value)
	spawner.simulation_speed = simulation_speed
