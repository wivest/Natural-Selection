extends Button

@export var root: BottomBar

func _on_pressed():
	root.restart_field()
