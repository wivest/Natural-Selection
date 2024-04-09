class_name View
extends Area2D

var target: Vector2 # target is in global scope

var _visible_food: Array[Food] = []
var _is_target_food: bool = false # target on creation is random

@onready var shape: CircleShape2D = $CollisionShape2D.shape

func _ready():
	target = _get_random_target()

func update_target(creature_velocity: Vector2):
	if _visible_food.size() == 0: # no visible food
		if _is_target_food: # update target from food to random
			target = _get_random_target()
			_is_target_food = false # set target is random
		if creature_velocity.dot(global_position.direction_to(target)) < 0: # if target is overcome
			target = _get_random_target()
	else:
		target = _find_closest_food()
		_is_target_food = true # set target is food

func _get_random_target() -> Vector2: # get random target on view circle
	var degree: float = randf() * 2 * PI
	var unit_circle: Vector2 = shape.radius * Vector2.UP.rotated(degree)
	return unit_circle + position

func _find_closest_food() -> Vector2: # find closest food from visible ones
	var new_target: Vector2 = _visible_food[0].position
	var min_sqr_distance: float = position.distance_squared_to(new_target)
	
	for food in _visible_food:
		var sqr_distance: float = global_position.distance_squared_to(food.global_position)
		if sqr_distance < min_sqr_distance:
			new_target = food.global_position
			min_sqr_distance = sqr_distance
	
	return new_target

func _on_area_entered(area: Area2D): # food appeared
	if area is Food:
		var food := area as Food
		_visible_food.append(food)

func _on_area_exited(area: Area2D): # food disappeared
	if area is Food:
		var food := area as Food
		_visible_food.erase(food)
