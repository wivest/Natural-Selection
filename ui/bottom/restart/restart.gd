extends Button

func _on_pressed():
	var event: InputEventAction = shortcut.events[0]
	Input.action_press(event.action)
	Input.action_release(event.action)
