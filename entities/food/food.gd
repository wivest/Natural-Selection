class_name Food
extends Area2D

var contains_energy: float = Parameters.food_energy
var eaten: bool = false

func _ready():
	Parameters.food_energy_changed.connect(
		func(): contains_energy = Parameters.food_energy
	)
