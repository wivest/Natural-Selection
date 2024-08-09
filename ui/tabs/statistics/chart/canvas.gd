class_name ChartCanvas
extends Control

@onready var counter: Counter = $Counter

func draw_edges(view_mode: ViewMode, data: ChartData):
	var view_data := ViewData.new(view_mode, data)
	var vratio: float = view_mode.get_vratio(data.nodes[view_data.start].y, view_data.minimum, view_data.maximum)
	var hratio: float = view_mode.get_hratio(0, view_data.delta)
	var prev := Vector2(size.x * hratio, size.y * vratio)

	for i in range(view_data.start + 1, view_data.end):
		vratio = view_mode.get_vratio(data.nodes[i].y, view_data.minimum, view_data.maximum)
		hratio = view_mode.get_hratio(data.get_relative_time(i, view_data.start), view_data.delta)

		var pos := Vector2(size.x * hratio, size.y * vratio)
		draw_line(prev, pos, Color.GRAY)
		prev = pos

	position_counter(view_mode.get_vratio(data.nodes[view_data.end - 1].y, view_data.minimum, view_data.maximum))

func draw_nodes(view_mode: ViewMode, data: ChartData):
	var view_data := ViewData.new(view_mode, data)

	for i in range(view_data.start, view_data.end):
		var vratio: float = view_mode.get_vratio(data.nodes[i].y, view_data.minimum, view_data.maximum)
		var hratio: float = view_mode.get_hratio(data.get_relative_time(i, view_data.start), view_data.delta)

		var pos := Vector2(size.x * hratio, size.y * vratio)
		draw_circle(pos, 3, Color.WHITE)

func position_counter(ratio: float):
	counter.anchor_top = ratio
	counter.anchor_bottom = ratio

class ViewData:
	var start: int
	var end: int

	var minimum: float
	var maximum: float
	var delta: float

	func _init(view_mode: ViewMode, data: ChartData):
		start = view_mode.get_start_index(data)
		end = view_mode.get_end_index(data)

		minimum = data.local_min(start, end)
		maximum = data.local_max(start, end)
		delta = view_mode.get_delta_time(data)
