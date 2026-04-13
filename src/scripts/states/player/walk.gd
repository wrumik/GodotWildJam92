extends State


func update(_delta: float) -> void:
	var direction = parent.direction
	var can_move: bool = parent.global_position == parent.target_position
	
	if direction.x > 0 && can_move:
		animation_player.play("walk_right")
		if !parent.collision_check.is_colliding():
			parent.target_position.x += 8
	elif direction.x < 0 && can_move:
		animation_player.play("walk_left")
		if !parent.collision_check.is_colliding():
			parent.target_position.x -= 8
	elif direction.y > 0 && can_move:
		animation_player.play("walk_down")
		if !parent.collision_check.is_colliding():
			parent.target_position.y += 8
	elif direction.y < 0 && can_move:
		animation_player.play("walk_up")
		if !parent.collision_check.is_colliding():
			parent.target_position.y -= 8
	
	if Input.is_action_just_pressed("attack"):
		switch_states("attack")
	
	if direction == Vector2.ZERO:
		switch_state.emit(self, "idle")
