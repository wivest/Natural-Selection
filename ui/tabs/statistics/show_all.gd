extends CheckButton

@export var chart: Chart

func _on_toggled(toggled_on: bool):
	chart.show_all = toggled_on
