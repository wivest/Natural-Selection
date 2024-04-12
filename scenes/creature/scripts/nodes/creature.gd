class_name Creature
extends CharacterBody2D

signal divided(creature_position: Vector2, genome: Genome)

const ENERGY_ON_START: float = 400 # subject to change
const DIVISION_LOWER_BOUND: float = 800 # subject to change
const DIVISION_ENERGY_CONSUMED: float = 400 # subject to change

@export var genome: Genome

var energy: float = ENERGY_ON_START

@onready var view: View = $View # visible area
@onready var body: Body = $Body # sprite

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