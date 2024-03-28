class_name Creature extends CharacterBody2D

@export var visible_area: CollisionShape2D

var speed: float = 40
var view: CircleShape2D

var target: Vector2
var foods: Array[Area2D] = []
var is_target_food: bool = false # first target is random

func _ready():
	view = visible_area.shape
	target = get_random_target() # target is not empty on init

func _physics_process(_delta):
	update_target()
	# print("target: ", target, " is food: ", is_target_food)
	velocity = speed * position.direction_to(target)
	move_and_slide()

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
		foods.append(area)

func _on_view_area_exited(area: Area2D): # food appeared
	if area is Food:
		foods.erase(area)

func _on_mouth_area_entered(area: Area2D): # food can be eaten
	if area is Food:
		area.queue_free()
