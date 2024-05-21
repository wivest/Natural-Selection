class_name SpawnerParameters
extends Resource

@export var spawn_rate: float = 10:
	set(value):
		spawn_rate = value
		changed.emit()
@export var on_start: int = 0
