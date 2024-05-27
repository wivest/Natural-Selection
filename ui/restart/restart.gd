extends Button

@export var scene: PackedScene
@export var parent: Node2D
@export var node: Field

func _on_pressed():
	node.queue_free()
	var instance = scene.instantiate()
	parent.add_child(instance)
	node = instance
