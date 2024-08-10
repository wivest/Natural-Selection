class_name Body
extends Sprite2D

static var speed_color_cap: float = 100

@export var speed_color: Gradient

func _ready():
	update_color(owner.genome.genes["speed"].value)

func update_color(speed: float):
	modulate = speed_color.sample(speed / speed_color_cap) # set color based on speed
