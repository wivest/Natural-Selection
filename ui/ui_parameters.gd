class_name UIParameters
extends Control

signal parameters_set(p: SimulationParameters)

var parameters: SimulationParameters:
	set(v):
		parameters = v
		parameters_set.emit(parameters)
