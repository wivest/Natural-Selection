extends HSlider

var parameters: SimulationParameters

func _on_value_changed(v: float):
	parameters.speed = v

func _on_parameters_set(p: SimulationParameters):
	parameters = p
