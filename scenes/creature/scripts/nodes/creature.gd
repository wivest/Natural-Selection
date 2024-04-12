class_name Creature extends CharacterBody2D

signal divided(creature_position: Vector2, genome: Genome)

const ENERGY_ON_START: float = 400 # subject to change
const DIVISION_LOWER_BOUND: float = 800 # subject to change
const DIVISION_ENERGY_CONSUMED: float = 400 # subject to change

const SPEED_COLOR_CAP: float = 100 # subject to change

const VIEW_COLOR: Color = Color("0099b320")

@export var genome: Genome
@export var speed_color: Gradient

var energy: float = ENERGY_ON_START

@onready var view: View = $View # visible area
@onready var body: Body = $Body # sprite

func _ready():
	view.shape.radius = genome.view_radius.value
	body.modulate = speed_color.sample(genome.speed.value / SPEED_COLOR_CAP) # set color based on speed

func _draw():
	draw_circle(Vector2.ZERO, genome.view_radius.value, VIEW_COLOR)

func _physics_process(delta):
	view.update_target(velocity)
	velocity = genome.speed.value * position.direction_to(view.target)
	move_and_slide()
	energy -= get_consumed_energy(delta)
	handle_energy_level()

func get_consumed_energy(delta: float) -> float: # based on speed
	return (genome.speed.value + genome.view_radius.value) * delta

func handle_energy_level():
	if energy < 0:
		queue_free()
	if energy > DIVISION_LOWER_BOUND:
		energy -= DIVISION_ENERGY_CONSUMED
		divided.emit(position, genome)

func _on_mouth_area_entered(area: Area2D): # food can be eaten
	if area is Food:
		var food := area as Food
		energy += food.contains_energy # renew energy contained by food
		area.queue_free()
