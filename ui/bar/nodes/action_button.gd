extends Button

var event: InputEventAction = shortcut.events[0]

func _ready():
	pressed.connect(_on_pressed)

func _on_pressed():
	Input.action_press(event.action)
	Input.action_release(event.action)
