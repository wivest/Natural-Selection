extends Control

@export var step: float = 0.2

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

	var distance: float = size.x / (max(population.size() - 1, 1))

	for i in range(population.size()):
		var ratio: float = float(population[i]) / maximum
		var pos := Vector2(i * distance, size.y * (1 - ratio))
		if i != 0:
			draw_line(prev, pos, Color.GRAY)
		draw_circle(pos, 3, Color.WHITE)
		prev = pos
