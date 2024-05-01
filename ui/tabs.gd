extends Button

@export var tabs: TabContainer

func _on_pressed():
	tabs.visible = not tabs.visible
