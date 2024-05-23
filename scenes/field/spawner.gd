class_name Spawner
extends Timer

@export var rate: float = 0:
	set(value):
		rate = value
		update_timer()

func _ready():
	Parameters.data.changed.connect(update_timer)

func update_timer():
	var wait_time_updated: float = 1 / (rate * Parameters.data.speed)
	var correlation: float = wait_time_updated / wait_time
	start(time_left * correlation)
	wait_time = wait_time_updated