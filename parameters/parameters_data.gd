class_name ParametersData
extends Resource

@export var speed: float = 1:
	set(value):
		speed = value
		changed.emit()

@export_group("Creature")
@export var creatures: int = 10
@export var energy_on_start: float = 400 # subject to change
@export var division_lower_bound: float = 800 # subject to change
@export var energy_consumed_on_division: float = 400 # subject to change

@export_group("Food")
@export var food: int = 10
@export var spawn_rate: float = 10
