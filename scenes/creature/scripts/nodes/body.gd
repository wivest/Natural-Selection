class_name Body
extends Sprite2D

const SPEED_COLOR_CAP: float = 100 # subject to change

@export var speed_color: Gradient

var _creature: Creature

func _ready():
	_creature = owner

func _process(_delta):
	var speed := _creature.genome.speed.value
	modulate = speed_color.sample(speed / SPEED_COLOR_CAP) # set color based on speed
