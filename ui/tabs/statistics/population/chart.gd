class_name Chart
extends Control

@export var step: float = 0.2
@export var length_limit: int = 500

var population: Array[Vector2] = []

var _previous_step: float = 0

func _process(_delta):
	var time := float(Time.get_ticks_msec()) / 1000
	if time - _previous_step >= step / Parameters.speed:
		_previous_step = time
		population.append(Vector2(time / Parameters.speed, Creature.count))
		queue_redraw()

	if Input.is_action_just_pressed(&"restart"):
		population = []
		_previous_step = time
		population.append(Vector2(time / Parameters.speed, Creature.count))

func _draw():
	var maximum: int = population.max().y
	var prev: Vector2

	var start_index: int = max(population.size() - length_limit, 0)
	var start_time: float = population[start_index].x
	var end_time: float = population[- 1].x
	var delta: float = end_time - start_time

	for i in range(start_index, population.size()):
		var ratio: float = population[i].y / maximum
		var time_ratio: float = (population[i].x - start_time) / delta
		var pos := Vector2(size.x * time_ratio, size.y * (1 - ratio))
		if i != start_index:
			draw_line(prev, pos, Color.GRAY)
		draw_circle(pos, 3, Color.WHITE)
		prev = pos
