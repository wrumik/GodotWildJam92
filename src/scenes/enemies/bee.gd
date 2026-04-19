class_name Bee
extends Enemy

var move_target: Vector2i
var moving: bool = false


func move() -> void:
	velocity = $GridMover.move_speed * global_position.direction_to(move_target)
	print(self, velocity, move_target, moving)
	
	move_and_slide()


func can_move() -> bool:
	if not $ChargeCooldown.is_stopped():
		return false
		
	var check = super.can_move()
	if check:
		if not moving:
			move_target = target.global_position
			moving = true
	elif target and moving:
		moving = false
		$ChargeCooldown.start()
		
	return check
