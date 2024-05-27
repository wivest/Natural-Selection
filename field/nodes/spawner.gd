class_name Spawner
extends Timer

@export var rate: float = 0

func _ready():
	update_timer()
	Parameters.data.changed.connect(update_timer)

func update_timer():
	rate = Parameters.data.spawn_rate
	var wait_time_updated: float = 1 / (rate * Parameters.data.speed)
	if is_inside_tree():
		var correlation: float = wait_time_updated / wait_time
		start(time_left * correlation)
	wait_time = wait_time_updated
