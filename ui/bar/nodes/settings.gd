extends Button

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	var event: InputEventAction = shortcut.events[0]
	Input.action_press(event.action)
	Input.action_release(event.action)
