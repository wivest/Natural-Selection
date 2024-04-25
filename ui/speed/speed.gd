extends HSlider

signal speed_changed(p: SimulationParameters)

var parameters: SimulationParameters

func _on_value_changed(v: float):
	parameters.speed = v
	speed_changed.emit(parameters)

func _on_parameters_changed(p: SimulationParameters):
	parameters = p
