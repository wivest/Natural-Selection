class_name ChartParameters
extends HBoxContainer

@export var getter: Getter
@export var padding: int = 2

@export var step_spinbox: SpinBox
@export var view_mode_optionbutton: OptionButton
@export var clear_button: Button

@onready var counter: Counter = $Counter

func _ready():
	counter.getter = getter
	counter.padding = padding
