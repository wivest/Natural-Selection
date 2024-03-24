extends CharacterBody2D

@export var visible_area: CollisionShape2D

var speed: float = 20
var view: CircleShape2D

var target: Vector2
var foods: Array[Vector2] = []
var is_target_food: bool = false # target is random

func _ready():
	view = visible_area.shape
	target = get_random_target() # target is not empty on init

func _physics_process(_delta):
	update_target()
	velocity = speed * position.direction_to(target)
	move_and_slide()

func update_target():
	if foods.size() == 0: # no visible food
		if is_target_food: # update target from food to random
			target = get_random_target()
			is_target_food = false
		if velocity.dot(position.direction_to(target)) < 0: # target is overcome
			target = get_random_target()
	else:
		is_target_food = true # set target is food
		target = find_closest_food()

func find_closest_food() -> Vector2: # find closest food from visible ones
	var new_target: Vector2 = target
	var min_sqr_distance: float = position.distance_squared_to(target)
	
	for food in foods:
		var sqr_distance: float = position.distance_squared_to(food)
		if sqr_distance < min_sqr_distance:
			new_target = food
			min_sqr_distance = sqr_distance
	
	return new_target

func get_random_target() -> Vector2:
	var degree: float = randf() * 2 * PI
	var unit_circle: Vector2 = view.radius * Vector2.UP.rotated(degree)
	return unit_circle + position
