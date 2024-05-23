class_name Area
extends Area2D

@onready var bounds: Rect2 = $Shape.shape.get_rect()

func get_random_point() -> Vector2:
	var x := randf_range(bounds.position.x, bounds.end.x)
	var y := randf_range(bounds.position.y, bounds.end.y)
	return Vector2(x, y)
