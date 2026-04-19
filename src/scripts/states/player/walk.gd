extends State

var played_bump: bool = false

func physics_update(_delta: float) -> void:
	var direction = parent.direction
	var can_move: bool = parent.global_position == parent.target_position
	var anim: String = "walk_"
	
	if direction.x > 0 && can_move:
		anim += "right"
		if parent.is_holding_ingredient:
			anim += "_ingredient"
		if !parent.right_collision_check.is_colliding():
			parent.target_position.x += 8
			played_bump = false
		else:
			collided_with(parent.right_collision_check.get_collider())
	elif direction.x < 0 && can_move:
		anim += "left"
		if parent.is_holding_ingredient:
			anim += "_ingredient"
		if !parent.left_collision_check.is_colliding():
			parent.target_position.x -= 8
			played_bump = false
		else:
			collided_with(parent.left_collision_check.get_collider())
	elif direction.y > 0 && can_move:
		anim += "down"
		if parent.is_holding_ingredient:
			anim += "_ingredient"
		if !parent.down_collision_check.is_colliding():
			parent.target_position.y += 8
			played_bump = false
		else:
			for id in parent.down_collision_check.get_collision_count():
				collided_with(parent.down_collision_check.get_collider(id))
	elif direction.y < 0 && can_move:
		anim += "up"
		if parent.is_holding_ingredient:
			anim += "_ingredient"
		if !parent.up_collision_check.is_colliding():
			parent.target_position.y -= 8
			played_bump = false
		else:
			for id in parent.up_collision_check.get_collision_count():
				collided_with(parent.up_collision_check.get_collider(id))
	
	if can_move:
		if animation_player.has_animation(anim):
			animation_player.play(anim)
	
	animation_player.speed_scale = parent.effective_speed_multiplier()
	#animation_player.speed_scale = remap(parent.speed, parent.base_speed, parent.speed + 1, 1.0, 1.3)
	

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
	var bumped: bool = true
	if collider is UnlockableBody:
		if parent.keys > 0:
			bumped = false
		if not bumped:
			parent.keys -= 1	
			collider.unlock()
			played_bump = false
	
	if bumped and not played_bump:
		played_bump = true
		SoundManager.play_sfx(Sounds.BUMP_WALL, 0.4)


func enter() -> void:
	played_bump = false
