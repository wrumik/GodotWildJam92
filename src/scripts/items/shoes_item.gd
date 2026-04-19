extends Item


func picked_up():
	holder.add_speed_multiplier("shoes", 1.45)
	queue_free()
