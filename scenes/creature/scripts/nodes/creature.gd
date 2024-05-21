class_name Creature
extends CharacterBody2D

signal divided(creature_position: Vector2, genome: Genome)

@export var genome: Genome

var energy: float = Parameters.data.energy_on_start

@onready var view: View = $View # visible area
@onready var body: Body = $Body # sprite

func _physics_process(delta):
	view.update_target(velocity)
	velocity = Parameters.data.speed * genome.speed.value * position.direction_to(view.target)
	move_and_slide()
	energy -= get_consumed_energy(delta)
	handle_energy_level()

func get_consumed_energy(delta: float) -> float: # based on speed
	return Parameters.data.speed * (genome.speed.value + genome.view_radius.value) * delta

func handle_energy_level():
	if energy < 0:
		queue_free()
	if energy > Parameters.data.division_lower_bound:
		energy -= Parameters.data.energy_consumed_on_division
		divided.emit(position, genome)

func _on_mouth_food_eaten(food: Food):
	energy += food.contains_energy
