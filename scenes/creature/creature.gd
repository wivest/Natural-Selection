class_name Creature extends CharacterBody2D

signal divided(creature_position: Vector2, genome: Genome)

const ENERGY_ON_START: float = 200 # subject to change
const DIVISION_LOWER_BOUND: float = 300 # subject to change
const DIVISION_ENERGY_CONSUMED: float = 100 # subject to change

const SPEED_COLOR_CAP: float = 100 # subject to change

@export var genome: Genome
@export var speed_color: Gradient

var energy: float = ENERGY_ON_START
var view: CircleShape2D

var target: Vector2
var foods: Array[Food] = []
var is_target_food: bool = false # first target is random

@onready var visible_area: CollisionShape2D = $View/CollisionShape2D

func _ready():
	view = visible_area.shape
	target = get_random_target() # target is not empty on init

func _process(_delta):
	modulate = speed_color.sample(genome.speed.value / SPEED_COLOR_CAP) # set color based on speed

func _physics_process(delta):
	update_target()
	velocity = genome.speed.value * position.direction_to(target)
	move_and_slide()
	energy -= get_consumed_energy(delta)
	handle_energy_level()

func update_target():
	if foods.size() == 0: # no visible food
		if is_target_food: # update target from food to random
			target = get_random_target()
			is_target_food = false # set target is random
		if velocity.dot(position.direction_to(target)) < 0: # if target is overcome
			target = get_random_target()
	else:
		target = find_closest_food()
		is_target_food = true # set target is food

func get_consumed_energy(delta: float) -> float: # based on speed
	return genome.speed.value * delta

func handle_energy_level():
	if energy < 0:
		queue_free()
	if energy > DIVISION_LOWER_BOUND:
		energy -= DIVISION_ENERGY_CONSUMED
		divided.emit(position, genome)

func find_closest_food() -> Vector2: # find closest food from visible ones
	var new_target: Vector2 = foods[0].position
	var min_sqr_distance: float = position.distance_squared_to(new_target)
	
	for food in foods:
		var sqr_distance: float = position.distance_squared_to(food.position)
		if sqr_distance < min_sqr_distance:
			new_target = food.position
			min_sqr_distance = sqr_distance
	
	return new_target

func get_random_target() -> Vector2: # get random target on view circle
	var degree: float = randf() * 2 * PI
	var unit_circle: Vector2 = view.radius * Vector2.UP.rotated(degree)
	return unit_circle + position

func _on_view_area_entered(area: Area2D): # food disappeared
	if area is Food:
		var food := area as Food
		foods.append(food)

func _on_view_area_exited(area: Area2D): # food appeared
	if area is Food:
		var food := area as Food
		foods.erase(food)

func _on_mouth_area_entered(area: Area2D): # food can be eaten
	if area is Food:
		var food := area as Food
		energy += food.contains_energy # renew energy contained by food
		area.queue_free()
