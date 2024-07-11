class_name Chart
extends MarginContainer

@export var getter: Getter
@export var parameters: ChartParameters

var data: ChartData = ChartData.new()
var length_limit: int = 200

var view_modes: Dictionary = {
	0: CurrentViewMode.new(length_limit),
	1: PageViewMode.new(length_limit, 0), # set time_step in _ready
	2: FullViewMode.new(),
}
var view_mode: ViewMode = CurrentViewMode.new(length_limit)

var _time: float:
	get:
		return Time.get_ticks_msec() / 1000.0
var _margin_size: Vector2:
	get:
		var x: float = size.x - get_theme_constant("margin_left") - get_theme_constant("margin_right")
		var y: float = size.y - get_theme_constant("margin_top") - get_theme_constant("margin_bottom")
		return Vector2(x, y)

@onready var counter: Counter = $Control/Counter

func _ready():
	view_modes[1].time_step = parameters.step.value

	parameters.step.value_changed.connect(func(v: float): view_modes[1].time_step=v; queue_redraw())
	parameters.view_mode.item_selected.connect(func(i: int): view_mode=view_modes[i];queue_redraw())
	parameters.clear.pressed.connect(clear_nodes)
	parameters.timer.timeout.connect(record_node)

func _process(_delta):
	if Input.is_action_just_pressed(&"restart"):
		clear_nodes()

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
		position_counter(vratio)

		var pos := Vector2(
			get_theme_constant("margin_left") + _margin_size.x * hratio,
			get_theme_constant("margin_top") + _margin_size.y * vratio
		)
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
	var node_time: float = previous_time + parameters.step.value
	data.nodes.append(Vector2(node_time, getter.get_value()))

	counter.value = getter.get_value()

	queue_redraw()

func position_counter(ratio: float):
	counter.anchor_top = ratio
	counter.anchor_bottom = ratio
