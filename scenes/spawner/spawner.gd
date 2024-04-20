class_name Spawner
extends Area2D

@export var item_scene: PackedScene
@export var spawn_rate: float:
	set(value):
		spawn_rate = value
		update_timer()
@export var items_on_start: int

@onready var timer: Timer = $Timer
@onready var bounds: Rect2 = $Bounds.shape.get_rect()
@onready var container: Node = $Container

func get_random_point() -> Vector2: # get random point inside bounds
	var x := randf_range(bounds.position.x, bounds.end.x)
	var y := randf_range(bounds.position.y, bounds.end.y)
	return Vector2(x, y)

func spawn_item() -> Node:
	var item := item_scene.instantiate()
	item.position = get_random_point() # set random position inside bounds
	item.rotation = randf_range(0, 2 * PI) # set random rotation
	container.add_child(item)

	return item

func _on_timer_timeout(): # spawn item on timer timeout
	spawn_item()

func _on_field_ready(): # use instead of _ready() function
	for i in range(items_on_start):
		spawn_item()

	timer.start()

func update_timer(): # update remaining time on change
	var new_wait_time: float = 1 / spawn_rate
	var correlation: float = new_wait_time / timer.wait_time
	timer.start(timer.time_left * correlation)
	timer.wait_time = new_wait_time
