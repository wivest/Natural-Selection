class_name Cocoon extends Sprite2D

signal incubated(cocoon_position: Vector2, genome: Gene)

@export var incubation_time: float = 1 # time before turning into a creature

var genome: Gene

@onready var timer: Timer = $Timer

func _ready():
	timer.start(incubation_time)

func _on_timer_timeout():
	incubated.emit(position, genome)
	queue_free()
