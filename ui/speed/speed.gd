extends HSlider

var parameters: ParametersData

func _on_value_changed(v: float):
	parameters.speed = v

func _on_parameters_set(p: ParametersData):
	parameters = p
