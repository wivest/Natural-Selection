class_name Cocoon extends Sprite2D

signal incubated(cocoon_position: Vector2, genome: Genome)

const INCUBATION_TIME_CAP: float = 1.5

@export var incubation_color: Gradient

var genome: Genome

var simulation_speed: float = 1:
	set = set_simulation_speed

@onready var timer: Timer = $Timer

func _ready():
	timer.start(genome.incubation_time.value / simulation_speed)

func _process(_delta):
	modulate = incubation_color.sample(simulation_speed * timer.time_left / INCUBATION_TIME_CAP)

func set_simulation_speed(value: float):
	if timer == null:
		simulation_speed = value
		return
	var new_incubation_time: float = timer.time_left * simulation_speed / value
	simulation_speed = value
	timer.start(new_incubation_time)

func _on_timer_timeout():
	incubated.emit(position, genome)
	queue_free()

func _on_simulation_speed_changed(new_speed: float):
	simulation_speed = new_speed
