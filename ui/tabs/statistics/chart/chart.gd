class_name Chart
extends Control

@export var parameters: ChartParameters

var data: ChartData = ChartData.new()
var length_limit: int = 500
var step: float = 0.2:
	set(value):
		step = value
		view_modes[1].time_step = value

var view_modes: Dictionary = {
	0: CurrentViewMode.new(length_limit),
	1: PageViewMode.new(length_limit, step),
	2: FullViewMode.new(),
}
var view_mode: ViewMode = CurrentViewMode.new(length_limit)

var _time: float:
	get:
		return Time.get_ticks_msec() / 1000.0
var _previous_step: float = 0

func _ready():
	parameters.step_spinbox.value = step

	parameters.step_spinbox.value_changed.connect(func(v: float): step=v)
	parameters.view_mode_optionbutton.item_selected.connect(func(i: int): view_mode=view_modes[i])
	parameters.clear_button.pressed.connect(clear_nodes)

func _process(_delta):
	if Input.is_action_just_pressed(&"restart"):
		clear_nodes()

	if get_tree().paused:
		queue_redraw()
		return

	if _time - _previous_step >= step / Parameters.speed:
		_previous_step = _time
		var previous_time = _time
		if data.nodes.size() > 0:
			previous_time = data.nodes[- 1].x
		var current_step: float = _delta * Parameters.speed
		if step != 0:
			current_step = step
		data.nodes.append(Vector2(previous_time + current_step, parameters.getter.get_value()))
		queue_redraw()

func _draw():
	if data.nodes.size() == 0:
		return

	var prev: Vector2

	var start_index: int = view_mode.get_start_index(data)
	var end_index: int = view_mode.get_end_index(data)

	var maximum: float = data.local_max(start_index, end_index)
	var delta: float = view_mode.get_delta_time(data)

	for i in range(start_index, end_index):
		var vratio: float = view_mode.get_vratio(data.nodes[i].y, maximum)
		var hratio: float = view_mode.get_hratio(data.get_relative_time(i, start_index), delta)

		var pos := Vector2(size.x * hratio, size.y * vratio)
		if i != start_index:
			draw_line(prev, pos, Color.GRAY)
		draw_circle(pos, 3, Color.WHITE)
		prev = pos

func clear_nodes():
	data = ChartData.new()
	_previous_step = _time
