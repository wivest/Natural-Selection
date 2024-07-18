class_name ViewRadiusGetter
extends Getter

func get_value() -> float:
	return Creature.average.genes["view_radius"].value
