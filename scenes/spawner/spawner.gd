extends Node2D

@export var food_scene: PackedScene
@export var spawn_rate: float = 1 # number of food per second

@onready var timer: Timer = $Timer
@onready var bounds: Rect2 = $Bounds/CollisionShape2D.shape.get_rect()
@onready var container: Node = $Container

func _ready():
	timer.wait_time = 1 / spawn_rate
	timer.start()

func get_random_point() -> Vector2: # get random point inside bounds
	var x := randf_range(bounds.position.x, bounds.end.x)
	var y := randf_range(bounds.position.y, bounds.end.y)
	return Vector2(x, y)

func _on_timer_timeout(): # spawn food on timer timeout
	var food: Food = food_scene.instantiate() as Food
	food.position = get_random_point() # set random position inside bounds
	food.rotation = randf_range(0, 2 * PI) # set random rotation
	container.add_child(food)
