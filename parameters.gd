class_name ParametersNode
extends Node

signal speed_changed
signal spawn_rate_changed

@export var speed: float = 1:
	set(value):
		speed = value
		speed_changed.emit()

@export_group("Creature")
@export var creatures: int = 10
@export var energy_on_start: float = 400 # subject to change
@export var division_lower_bound: float = 800 # subject to change
@export var energy_consumed_on_division: float = 400 # subject to change

@export_group("Factors")
@export var speed_multiplier: float = 1
@export var speed_power: float = 1

@export_group("Food")
@export var food: int = 10
@export var spawn_rate: float = 10:
	set(value):
		spawn_rate = value
		spawn_rate_changed.emit()
