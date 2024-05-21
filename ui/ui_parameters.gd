class_name UIParameters
extends Control

signal parameters_set(p: ParametersData)

var parameters: ParametersData:
	set(v):
		parameters = v
		parameters_set.emit(parameters)
