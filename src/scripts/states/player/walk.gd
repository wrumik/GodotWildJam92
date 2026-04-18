extends State


func physics_update(_delta: float) -> void:
	var direction = parent.direction
	var can_move: bool = parent.global_position == parent.target_position
	
	if direction.x > 0 && can_move:
		animation_player.play("walk_right")
		if !parent.right_collision_check.is_colliding():
			parent.target_position.x += 8
		else:
			collided_with(parent.right_collision_check.get_collider())
	elif direction.x < 0 && can_move:
		animation_player.play("walk_left")
		if !parent.left_collision_check.is_colliding():
			parent.target_position.x -= 8
		else:
			collided_with(parent.left_collision_check.get_collider())
	elif direction.y > 0 && can_move:
		animation_player.play("walk_down")
		if !parent.down_collision_check.is_colliding():
			parent.target_position.y += 8
		else:
			for id in parent.down_collision_check.get_collision_count():
				collided_with(parent.down_collision_check.get_collider(id))
	elif direction.y < 0 && can_move:
		animation_player.play("walk_up")
		if !parent.up_collision_check.is_colliding():
			parent.target_position.y -= 8
		else:
			for id in parent.up_collision_check.get_collision_count():
				collided_with(parent.up_collision_check.get_collider(id))
	animation_player.speed_scale = remap(parent.speed, parent.base_speed, parent.speed + 1, 1.0, 1.3)

func update(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		switch_states("attack")
	
	if parent.direction == Vector2.ZERO:
		switch_state.emit(self, "idle")
	
	if Input.is_action_just_pressed("pickup") && !parent.is_holding_ingredient:
		parent.pickup_ingredient()
	if Input.is_action_just_pressed("pickup") && parent.is_holding_ingredient:
		parent.drop_ingredient()

func exit() -> void:
	animation_player.speed_scale = 1.0


func collided_with(collider: Node2D) -> void:
	if collider is UnlockableBody:
		if parent.keys <= 0:
			return
			
		parent.keys -= 1	
		collider.unlock()
