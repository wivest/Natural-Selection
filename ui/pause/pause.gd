extends Button

const WHEN_PROCESSED: String = "Pause"
const WHEN_PAUSED: String = "Continue"

func _on_pressed():
	var tree := get_tree()
	tree.paused = not tree.paused
	if tree.paused:
		text = WHEN_PAUSED
	else:
		text = WHEN_PROCESSED
