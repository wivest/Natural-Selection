class_name Chart
extends Control

@export var step: float = 0.2
@export var length_limit: int = 500

var population: Array[Vector2] = []
var show_all: bool = false

var _previous_step: float = 0

func _process(_delta):
	var time := float(Time.get_ticks_msec()) / 1000
	if time - _previous_step >= step / Parameters.speed:
		_previous_step = time
		var previous_time = time
		if population.size() > 0:
			previous_time = population[- 1].x
		population.append(Vector2(previous_time + step, Creature.count))
		queue_redraw()

	if Input.is_action_just_pressed(&"restart"):
		population = []
		_previous_step = time
		population.append(Vector2(time * Parameters.speed, Creature.count))

func _draw():
	var prev: Vector2

	var start_index: int
	if show_all:
		start_index = 0
	else:
		start_index = max(population.size() - length_limit, 0)

	var maximum: float = local_maximum(start_index, population.size())
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

func local_maximum(start: int, end: int) -> float:
	var maximum: float = population[start].y
	for i in range(start, end):
		maximum = max(maximum, population[i].y)
	return maximum
