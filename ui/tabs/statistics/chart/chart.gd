class_name Chart
extends Control

@export var parameters: ChartParameters

var data: ChartData = ChartData.new()
var length_limit: int = 500

var view_modes: Dictionary = {
	0: CurrentViewMode.new(length_limit),
	1: PageViewMode.new(length_limit, 0), # set time_step in _ready
	2: FullViewMode.new(),
}
var view_mode: ViewMode = CurrentViewMode.new(length_limit)

var _time: float:
	get:
		return Time.get_ticks_msec() / 1000.0

func _ready():
	view_modes[1].time_step = parameters.step_spinbox.value

	parameters.step_spinbox.value_changed.connect(func(v: float): view_modes[1].time_step=v)
	parameters.view_mode_optionbutton.item_selected.connect(func(i: int): view_mode=view_modes[i])
	parameters.clear_button.pressed.connect(clear_nodes)
	parameters.timer.timeout.connect(record_node)

func _process(_delta):
	if Input.is_action_just_pressed(&"restart"):
		clear_nodes()

	if get_tree().paused:
		queue_redraw()
		return

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
	record_node()
	parameters.timer.start()

func record_node():
	var previous_time = _time
	if data.nodes.size() > 0:
		previous_time = data.nodes[- 1].x
	var node_time: float = previous_time + parameters.step_spinbox.value
	data.nodes.append(Vector2(node_time, parameters.getter.get_value()))

	queue_redraw()
