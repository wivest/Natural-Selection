class_name HatchingTimeGetter
extends Getter

func get_value() -> float:
	return Creature.average.genes["hatching_time"].value
