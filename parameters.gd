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
var speed_color_cap: float:
	set(value):
		Body.speed_color_cap = value
	get:
		return Body.speed_color_cap
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
