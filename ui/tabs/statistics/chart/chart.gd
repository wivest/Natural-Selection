class_name Chart
extends Control

@export var getter: Getter

@export var step: float = 0.2
@export var length_limit: int = 500

var data: ChartData = ChartData.new()

var view_mode: ViewMode = CurrentViewMode.new(length_limit)

var _previous_step: float = 0

@onready var step_spinbox: SpinBox = $"../Parameters/Step" # TODO: refactor parameters
@onready var show_all_checkbutton: CheckButton = $"../Parameters/ShowAll" # TODO: refactor parameters
@onready var show_page_checkbutton: CheckButton = $"../Parameters/ShowPage" # TODO: refactor parameters
@onready var clear_button: Button = $"../Parameters/Clear" # TODO: refactor parameters

func _ready():
	step_spinbox.value = step

	step_spinbox.value_changed.connect(func(v: float): step=v)
	clear_button.pressed.connect(func(): data=ChartData.new())

func _process(_delta):
	if get_tree().paused:
		return

	var time := float(Time.get_ticks_msec()) / 1000
	if time - _previous_step >= step / Parameters.speed:
		_previous_step = time
		var previous_time = time
		if data.nodes.size() > 0:
			previous_time = data.nodes[- 1].x
		var current_step: float = _delta * Parameters.speed
		if step != 0:
			current_step = step
		data.nodes.append(Vector2(previous_time + current_step, getter.get_value()))
		queue_redraw()

	if Input.is_action_just_pressed(&"restart"):
		data = ChartData.new()
		_previous_step = time

func _draw():
	var prev: Vector2

	var start_index: int = view_mode.get_start_index(data)

	var maximum: float = data.local_max(start_index, data.nodes.size())
	var start_time: float = data.nodes[start_index].x
	var end_time: float = data.nodes[- 1].x
	var delta: float = end_time - start_time

	for i in range(start_index, data.nodes.size()):
		var ratio: float = view_mode.get_vratio(data.nodes[i].y, maximum)
		var time_ratio: float = (data.nodes[i].x - start_time) / delta

		var pos := Vector2(size.x * time_ratio, size.y * ratio)
		if i != start_index:
			draw_line(prev, pos, Color.GRAY)
		draw_circle(pos, 3, Color.WHITE)
		prev = pos
