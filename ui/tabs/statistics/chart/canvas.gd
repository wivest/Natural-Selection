class_name ChartCanvas
extends Control

@onready var counter: Counter = $Counter

func draw_edges(view_mode: ViewMode, data: ChartData, start: int, end: int, minimum: float, maximum: float, delta: float):
	var vratio: float = view_mode.get_vratio(data.nodes[start].y, minimum, maximum)
	var hratio: float = view_mode.get_hratio(0, delta)
	var prev := Vector2(size.x * hratio, size.y * vratio)

	for i in range(start + 1, end):
		vratio = view_mode.get_vratio(data.nodes[i].y, minimum, maximum)
		hratio = view_mode.get_hratio(data.get_relative_time(i, start), delta)
		position_counter(vratio)

		var pos := Vector2(size.x * hratio, size.y * vratio)
		draw_line(prev, pos, Color.GRAY)
		prev = pos

func draw_nodes(view_mode: ViewMode, data: ChartData, start: int, end: int, minimum: float, maximum: float, delta: float):
	for i in range(start, end):
		var vratio: float = view_mode.get_vratio(data.nodes[i].y, minimum, maximum)
		var hratio: float = view_mode.get_hratio(data.get_relative_time(i, start), delta)
		position_counter(vratio)

		var pos := Vector2(size.x * hratio, size.y * vratio)
		draw_circle(pos, 3, Color.WHITE)

func position_counter(ratio: float):
	counter.anchor_top = ratio
	counter.anchor_bottom = ratio
