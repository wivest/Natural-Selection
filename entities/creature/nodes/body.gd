class_name Body
extends Sprite2D

static var color_speed_min: float = 20:
	set(value):
		color_speed_min = value
static var color_speed_max: float = 100:
	set(value):
		color_speed_max = value

@export var speed_color: Gradient

func _process(_delta):
	update_color(owner.genome.genes["speed"].value)

func update_color(speed: float):
	modulate = speed_color.sample((speed - color_speed_min) / color_speed_max) # set color based on speed
