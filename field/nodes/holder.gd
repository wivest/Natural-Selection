class_name Holder
extends Node

@export var item: PackedScene

func create(at_position: Vector2, angle: float=0) -> Node2D:
	var instance: Node2D = item.instantiate()
	instance.position = at_position
	instance.rotation_degrees = angle
	return instance

func add(node: Node2D):
	add_child(node)

func free_children():
	for child in get_children():
		child.free()
