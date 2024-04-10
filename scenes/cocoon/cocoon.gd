class_name Cocoon extends Sprite2D

signal incubated(cocoon_position: Vector2, genome: Genome)

var genome: Genome

@onready var timer: Timer = $Timer

func _ready():
	timer.start(genome.incubation_time.value)

func _on_timer_timeout():
	incubated.emit(position, genome)
	queue_free()
