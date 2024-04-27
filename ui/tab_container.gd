extends TabContainer

var parameters: SimulationParameters

func _on_parameters_set(p: SimulationParameters):
	parameters = p

func _on_on_start_field_changed(v: float):
	parameters.energy_on_start = v

func _on_lower_bound_field_changed(v: float):
	parameters.division_lower_bound = v

func _on_on_division_field_changed(v: float):
	parameters.energy_consumed_on_division = v
