class_name Chart
extends MarginContainer

@export var getter: Getter
@export var parameters: ChartParameters
@export var padding: int = 2

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

@onready var chart_name: Label = $Name
@onready var canvas: ChartCanvas = $Canvas

func _ready():
	chart_name.text = name
	canvas.counter.padding = padding
	view_modes[1].time_step = parameters.step.value

	parameters.step.value_changed.connect(func(v: float): view_modes[1].time_step = v; canvas.queue_redraw())
	parameters.view_mode.item_selected.connect(func(i: int): view_mode = view_modes[i]; canvas.queue_redraw())
	parameters.clear.pressed.connect(clear_nodes)
	parameters.timer.timeout.connect(record_node)
	canvas.draw.connect(update_canvas)

func _process(_delta):
	if Input.is_action_just_pressed(&"restart"):
		clear_nodes()

func update_canvas():
	if data.nodes.size() == 0:
		return

	canvas.draw_edges(view_mode, data)
	canvas.draw_nodes(view_mode, data)

func clear_nodes():
	data = ChartData.new()
	record_node()
	parameters.timer.start()

func record_node():
	var previous_time = _time
	if data.nodes.size() > 0:
		previous_time = data.nodes[-1].x
	var node_time: float = previous_time + parameters.step.value
	data.nodes.append(Vector2(node_time, getter.get_value()))

	canvas.counter.value = getter.get_value()
	canvas.queue_redraw()
