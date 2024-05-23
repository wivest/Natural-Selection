class_name Field
extends Node2D

@onready var area: Area = $Area
@onready var creatures: Holder = $Creatures
@onready var foods: Holder = $Foods

func _ready():
	for i in range(Parameters.data.creature_spawner.on_start):
		var creature = creatures.create(area.get_random_point())
		creatures.add(creature)

	for i in range(Parameters.data.food_spawner.on_start):
		spawn_food()

func spawn_food():
	var angle: float = randf() * 360
	var food = foods.create(area.get_random_point(), angle)
	foods.add(food)

func _on_spawner_timeout():
	spawn_food()
