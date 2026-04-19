class_name UnlockableBody
extends StaticBody2D

var unlocked: bool = false

func unlock() -> void:
	queue_free()
	unlocked = true
	for b in %Unlocks.get_overlapping_bodies():
		if b is UnlockableBody and not b.unlocked:
			b.unlock()
