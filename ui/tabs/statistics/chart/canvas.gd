class_name ChartCanvas
extends Control

@onready var counter: Counter = $Counter

func position_counter(ratio: float):
	counter.anchor_top = ratio
	counter.anchor_bottom = ratio
