extends Control

enum TabsState {NONE, SETTINGS}

var opened: TabsState = TabsState.NONE

@onready var tabs: Dictionary = {
	TabsState.NONE: $None,
	TabsState.SETTINGS: $Settings
}

func _process(_delta):
	if Input.is_action_just_pressed(&"open_settings"):
		switch_state(TabsState.SETTINGS)

func switch_state(state: TabsState):
	tabs[opened].visible = false
	if opened == state:
		opened = TabsState.NONE
	else:
		opened = state
	tabs[opened].visible = true
