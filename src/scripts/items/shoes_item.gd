extends Item


func picked_up():
	holder.speed += 40
	queue_free()
