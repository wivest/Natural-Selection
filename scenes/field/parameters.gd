class_name SimulationParameters
extends Resource

@export var speed: float = 1:
	set(value):
		speed = value
		changed.emit()
@export var food_spawn_rate: float = 10
@export var creatures_on_start: float = 10

@export_group("Creature energy")
@export var energy_on_start: float = 400 # subject to change
@export var division_lower_bound: float = 800 # subject to change
@export var energy_consumed_on_division: float = 400 # subject to change
