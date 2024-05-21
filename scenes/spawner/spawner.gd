class_name Spawner
extends Area2D

signal item_spawned(item: Node)

@export var item_scene: PackedScene
@export var parameters: SpawnerParameters

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

	item_spawned.emit(item)
	return item

func _on_timer_timeout(): # spawn item on timer timeout
	container.add_child(spawn_item())

func _on_field_ready(): # use instead of _ready() function
	for i in range(parameters.on_start):
		container.add_child(spawn_item())

	if parameters.spawn_rate != 0:
		timer.start()

func update_timer(): # update remaining time on change
	if parameters.spawn_rate == 0:
		timer.wait_time = 1
		timer.stop()
		return

	var new_wait_time: float = 1 / (parameters.spawn_rate * Parameters.data.speed)
	var correlation: float = new_wait_time / timer.wait_time
	timer.start(timer.time_left * correlation)
	timer.wait_time = new_wait_time
