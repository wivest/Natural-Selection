class_name SpeedGetter
extends Getter

func get_value() -> float:
	return Creature.average.genes["speed"].value
