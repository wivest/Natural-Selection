class_name Creature
extends CharacterBody2D

signal born(at_position: Vector2, genes: Genome)

static var count: int = 0
static var average: Genome

@export var genome: Genome
@export var egg: PackedScene

var energy: float = Parameters.energy_on_start

@onready var view: View = $View # visible area

func _enter_tree():
	count += 1

	var copy: Genome = genome.deep_copy()
	if count == 1:
		average = copy
	else:
		copy.sub(average)
		copy.div(count)
		average.add(copy)

func _exit_tree():
	count -= 1

	var copy: Genome = genome.deep_copy()
	if count == 0:
		average.zero()
	else:
		copy.sub(average)
		copy.div(count)
		average.sub(copy)

func _physics_process(delta):
	view.update_target(velocity)
	velocity = Parameters.speed * genome.genes["speed"].value * position.direction_to(view.target)
	move_and_slide()
	energy -= get_consumed_energy(delta)
	handle_energy_level()

func get_consumed_energy(delta: float) -> float: # based on speed
	return Parameters.speed * Energy.calculate(genome) * delta

func handle_energy_level():
	if energy < 0:
		queue_free()
	if energy > Parameters.division_lower_bound:
		energy -= Parameters.energy_on_start
		lay_egg()

func lay_egg():
	var egg_instance: Egg = egg.instantiate()
	egg_instance.position = position
	egg_instance.genome = genome.divide()
	egg_instance.hatched.connect(_on_egg_hatched) # ERROR: not born if died
	add_sibling(egg_instance)

func _on_egg_hatched(at_position: Vector2, genes: Genome):
	born.emit(at_position, genes)

func _on_mouth_food_eaten(food: Food):
	energy += food.contains_energy
