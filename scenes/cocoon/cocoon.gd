class_name Cocoon extends Sprite2D

signal incubated(cocoon_position: Vector2)

@export var incubation_time: float = 1 # time before turning into a creature

@onready var timer: Timer = $Timer

func _ready():
	timer.start(incubation_time)

func _on_timer_timeout():
	incubated.emit(position)
	queue_free()
