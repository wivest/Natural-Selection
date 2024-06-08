extends Control

enum TabsState {NONE, SETTINGS, STATISTICS}

var opened: TabsState = TabsState.NONE

@onready var tabs: Dictionary = {
	TabsState.NONE: $None,
	TabsState.SETTINGS: $Settings,
	TabsState.STATISTICS: $Statistics
}

func _process(_delta):
	if Input.is_action_just_pressed(&"open_settings"):
		switch_state(TabsState.SETTINGS)
	elif Input.is_action_just_pressed(&"open_statistics"):
		switch_state(TabsState.STATISTICS)

func switch_state(state: TabsState):
	tabs[opened].visible = false
	if opened == state:
		opened = TabsState.NONE
	else:
		opened = state
	tabs[opened].visible = true
