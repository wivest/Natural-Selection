class_name BottomBar
extends HBoxContainer

signal settings_requested

@export var scene: PackedScene
@export var parent: Node2D
@export var node: Field

func _physics_process(_delta):
	if Input.is_action_just_pressed(&"restart"):
		restart_field()

func restart_field():
	node.queue_free()
	var instance = scene.instantiate()
	parent.add_child(instance)
	node = instance