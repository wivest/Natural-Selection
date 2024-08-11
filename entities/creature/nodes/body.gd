class_name Body
extends Sprite2D

static var color_speed_min: float = 100
static var speed_color_cap: float = 100:
	set(value):
		speed_color_cap = value

@export var speed_color: Gradient

func _process(_delta):
	update_color(owner.genome.genes["speed"].value)

func update_color(speed: float):
	modulate = speed_color.sample((speed - color_speed_min) / speed_color_cap) # set color based on speed
