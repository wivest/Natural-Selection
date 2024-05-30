extends HSlider

func _on_value_changed(v: float):
	Parameters.data.speed = v
