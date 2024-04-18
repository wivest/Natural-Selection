class_name Cocoon extends Sprite2D

signal incubated(cocoon_position: Vector2, genome: Genome)

const INCUBATION_TIME_CAP: float = 1.5

@export var incubation_color: Gradient

var genome: Genome

var parameters: SimulationParameters

@onready var timer: Timer = $Timer

func _ready():
	timer.start(genome.incubation_time.value / parameters.speed)

func _process(_delta):
	modulate = incubation_color.sample(parameters.speed * timer.time_left / INCUBATION_TIME_CAP)

func _on_timer_timeout():
	incubated.emit(position, genome)
	queue_free()
