extends State


func enter() -> void:
	if parent.item_instance == null:
		switch_states("idle")
		return
	
	if parent.is_holding_ingredient:
		switch_states("idle")
		return
	
	var last_direction = parent.last_direction
	
	if last_direction.x > 0:
		animation_player.play("swing_right")
		parent.item_instance.use()
	if last_direction.x < 0:
		animation_player.play("swing_left")
		parent.item_instance.use()
	if last_direction.y > 0:
		animation_player.play("swing_down")
		parent.item_instance.use()
	if last_direction.y < 0:
		animation_player.play("swing_up")
		parent.item_instance.use()
	
	await animation_player.animation_finished
	
	switch_states("idle")
