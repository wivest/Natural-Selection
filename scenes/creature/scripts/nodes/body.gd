class_name Body
extends Sprite2D

const SPEED_COLOR_CAP: float = 100 # subject to change

@export var speed_color: Gradient

var _listened_gene: Gene

func _ready():
	var creature: Creature = owner as Creature # get parent Creature
	_listened_gene = creature.genome.speed # set Gene to listen to
	modulate = speed_color.sample(_listened_gene.value / SPEED_COLOR_CAP) # set color based on speed
