extends TabContainer

func _on_on_start_field_changed(v: float):
	Parameters.data.energy_on_start = v

func _on_lower_bound_field_changed(v: float):
	Parameters.data.division_lower_bound = v

func _on_on_division_field_changed(v: float):
	Parameters.data.energy_consumed_on_division = v

func _on_spawner_on_start_field_changed(v: float):
	Parameters.data.food_on_start = v as int

func _on_spawn_rate_field_changed(v: float):
	Parameters.data.food_spawn_rate = v
