class_name Mouth
extends Area2D

signal food_eaten(food: Food)

func _on_area_entered(area: Area2D): # food can be eaten
	if area is Food:
		var food := area as Food
		food_eaten.emit(food)
		area.queue_free()
