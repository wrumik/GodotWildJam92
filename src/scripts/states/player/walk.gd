extends State


func physics_update(_delta: float) -> void:
	var direction = parent.direction
	var can_move: bool = parent.global_position == parent.target_position
	
	if direction.x > 0 && can_move:
		animation_player.play("walk_right")
		if !parent.right_collision_check.is_colliding():
			parent.target_position.x += 8
	elif direction.x < 0 && can_move:
		animation_player.play("walk_left")
		if !parent.left_collision_check.is_colliding():
			parent.target_position.x -= 8
	elif direction.y > 0 && can_move:
		animation_player.play("walk_down")
		if !parent.down_collision_check.is_colliding():
			parent.target_position.y += 8
	elif direction.y < 0 && can_move:
		animation_player.play("walk_up")
		if !parent.up_collision_check.is_colliding():
			parent.target_position.y -= 8

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		switch_states("attack")
	
	if parent.direction == Vector2.ZERO:
		switch_state.emit(self, "idle")
