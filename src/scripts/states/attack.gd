extends State


func enter() -> void:
	if parent.held_weapon == null:
		switch_states("idle")
		return
	
	var last_direction = parent.last_direction
	
	if last_direction.x > 0:
		animation_player.play("swing_right")
	if last_direction.x < 0:
		animation_player.play("swing_left")
	if last_direction.y > 0:
		animation_player.play("swing_down")
	if last_direction.y < 0:
		animation_player.play("swing_up")
	
	await animation_player.animation_finished
	
	switch_states("idle")
