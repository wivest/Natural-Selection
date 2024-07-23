class_name Spawner
extends TimerLow

var rate: float = 0:
	set(v):
		rate = v
		update_timer()

func _ready():
	rate = Parameters.spawn_rate
	Parameters.speed_changed.connect(func(): rate=Parameters.spawn_rate)
	Parameters.spawn_rate_changed.connect(func(): rate=Parameters.spawn_rate)

func update_timer():
	var wait_time_updated: float = 1 / (rate * Parameters.speed)
	if is_inside_tree():
		var correlation: float = wait_time_updated / wait_time
		start(time_left * correlation)
	wait_time = wait_time_updated
