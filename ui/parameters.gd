class_name UIParameters
extends Control

signal parameters_changed(p: SimulationParameters)

var parameters: SimulationParameters:
	set(p):
		parameters = p
		parameters_changed.emit(parameters)

func _on_parameters_changed(p: SimulationParameters):
	parameters = p
