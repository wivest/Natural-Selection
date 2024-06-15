class_name Spawner
extends Timer

var rate: float = 0

func _ready():
	update_timer()
	Parameters.speed_changed.connect(update_timer)
	Parameters.spawn_rate_changed.connect(update_timer)

func update_timer():
	rate = Parameters.spawn_rate
	var wait_time_updated: float = 1 / (rate * Parameters.speed)
	if is_inside_tree():
		var correlation: float = wait_time_updated / wait_time
		start(time_left * correlation)
	wait_time = wait_time_updated
