extends Button

func _on_pressed():
	var tree := get_tree()
	tree.paused = not tree.paused
