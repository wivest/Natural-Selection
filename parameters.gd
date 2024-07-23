class_name ParametersNode
extends Node

signal speed_changed
signal spawn_rate_changed

var speed: float = 1:
	set(value):
		speed = value
		speed_changed.emit()

# creature
var creatures: int = 10
var energy_on_start: float = 400 # subject to change
var division_lower_bound: float = 800 # subject to change
var energy_consumed_on_division: float = 400 # subject to change

# factors
var speed_multiplier: float = 1:
	set(value):
		speed_multiplier = value
		Energy.factors["speed"].multiplier = value
var speed_power: float = 1:
	set(value):
		speed_power = value
		Energy.factors["speed"].power = value

# food
var food: int = 10
var spawn_rate: float = 10:
	set(value):
		spawn_rate = value
		spawn_rate_changed.emit()
