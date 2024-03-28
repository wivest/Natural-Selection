extends Area2D

@export var creature_scene: PackedScene
@export var cocoon_scene: PackedScene
@export var creatures_on_start: int = 10

@onready var bounds: Rect2 = $CollisionShape2D.shape.get_rect()
@onready var container: Node = $Container

func _ready():
	for i in range(creatures_on_start):
		_instantiate_creature(get_random_point())

func get_random_point() -> Vector2: # get random point inside bounds
	var x := randf_range(bounds.position.x, bounds.end.x)
	var y := randf_range(bounds.position.y, bounds.end.y)
	return Vector2(x, y)

func _instantiate_creature(creature_position: Vector2):
	var creature: Creature = creature_scene.instantiate() as Creature
	creature.position = creature_position
	creature.divided.connect(_on_creature_divided)
	
	container.add_child(creature)

func _instantiate_cocoon(cocoon_position: Vector2):
	var cocoon: Cocoon = cocoon_scene.instantiate() as Cocoon
	cocoon.position = cocoon_position
	cocoon.incubated.connect(_on_cocoon_incubated)
	
	container.add_child(cocoon)

func _on_creature_divided(creature_position: Vector2):
	_instantiate_cocoon(creature_position)

func _on_cocoon_incubated(cocoon_position: Vector2):
	_instantiate_creature(cocoon_position)
