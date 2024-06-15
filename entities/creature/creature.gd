class_name Creature
extends CharacterBody2D

signal born(at_position: Vector2, genes: Genome)

static var count: int = 0

@export var genome: Genome
@export var egg: PackedScene

var energy: float = Parameters.data.energy_on_start

@onready var view: View = $View # visible area

func _enter_tree():
	count += 1

func _exit_tree():
	count -= 1

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
		lay_egg()

func lay_egg():
	var egg_instance: Egg = egg.instantiate()
	egg_instance.position = position
	egg_instance.genome = genome.divide()
	egg_instance.hatched.connect(_on_egg_hatched)
	add_sibling(egg_instance)

func _on_egg_hatched(at_position: Vector2, genes: Genome):
	born.emit(at_position, genes)

func _on_mouth_food_eaten(food: Food):
	energy += food.contains_energy
