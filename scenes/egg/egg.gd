class_name Egg
extends Sprite2D

signal hatched(at_position: Vector2, genes: Genome)

const HATCHING_TIME_CAP: float = 1.5

@export var hatching_color: Gradient

var genome: Genome

@onready var timer: Timer = $Timer

func _ready():
	Parameters.data.changed.connect(_on_parameters_changed)
	timer.start(genome.hatching_time.value / Parameters.data.speed)

func _process(_delta):
	modulate = hatching_color.sample(Parameters.data.speed * timer.time_left / HATCHING_TIME_CAP)

func _on_timer_timeout():
	hatched.emit(position, genome)
	queue_free()

func _on_parameters_changed(): # update remaining time on change
	var new_wait_time: float = genome.hatching_time.value / Parameters.data.speed
	var correlation: float = new_wait_time / timer.wait_time
	timer.start(timer.time_left * correlation)
	timer.wait_time = new_wait_time
