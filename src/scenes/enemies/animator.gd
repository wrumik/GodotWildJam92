class_name Animator
extends AnimationPlayer


func update(_motion: Vector2, looking: Vector2, _delta: float) -> void:
	var cardinal = GridMover.dir_to_cardinal(looking)
	
	match cardinal:
		Vector2i.LEFT:
			play("move_left")
		Vector2i.RIGHT:
			play("move_right")
		Vector2i.UP:
			play("move_up")
		Vector2i.DOWN:
			play("move_down")
