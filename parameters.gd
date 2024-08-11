class_name ParametersNode
extends Node

signal speed_changed
signal spawn_rate_changed
signal food_energy_changed

var speed: float = 1:
	set(value):
		speed = value
		speed_changed.emit()

# creature
var creatures: int = 10
var color_speed_min: float:
	set(value):
		Body.color_speed_min = value
	get:
		return Body.color_speed_min
var color_speed_max: float:
	set(value):
		Body.color_speed_max = value
	get:
		return Body.color_speed_max
var energy_on_start: float = 400
var division_lower_bound: float = 800

# food
var food: int = 10
var spawn_rate: float = 10:
	set(value):
		spawn_rate = value
		spawn_rate_changed.emit()
var food_energy: float = 350:
	set(value):
		food_energy = value
		food_energy_changed.emit()
