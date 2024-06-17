class_name Chart
extends Control

@export var step: float = 0.2
@export var length_limit: int = 500

var population: Array[int] = []

var _previous_step: float = 0

func _process(_delta):
	var time := float(Time.get_ticks_msec()) / 1000
	if time - _previous_step >= step / Parameters.speed:
		_previous_step = time
		population.append(Creature.count)
		queue_redraw()

	if Input.is_action_just_pressed(&"restart"):
		population = []
		_previous_step = time
		population.append(Creature.count)

func _draw():
	var maximum: int = population.max()
	var prev: Vector2

	var distance: float = size.x / min(population.size() - 1, length_limit)
	var start_index: int = max(population.size() - length_limit, 0)

	for i in range(start_index, population.size()):
		var ratio: float = float(population[i]) / maximum
		var pos := Vector2((i - start_index) * distance, size.y * (1 - ratio))
		if i != start_index:
			draw_line(prev, pos, Color.GRAY)
		draw_circle(pos, 3, Color.WHITE)
		prev = pos
