extends State


func enter() -> void:
	if "_up" in animation_player.current_animation:
		animation_player.play("idle_up")
	if "_down" in animation_player.current_animation:
		animation_player.play("idle_down")
	if "_left" in animation_player.current_animation:
		animation_player.play("idle_left")
	if "_right" in animation_player.current_animation:
		animation_player.play("idle_right")


func update(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		switch_states("attack")
	if parent.direction:
		switch_states("walk")
	
	if Input.is_action_just_pressed("pickup") && !parent.is_holding_ingredient:
		parent.pickup_ingredient()
	if Input.is_action_just_pressed("pickup") && parent.is_holding_ingredient:
		parent.drop_ingredient()
