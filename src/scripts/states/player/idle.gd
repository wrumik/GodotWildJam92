extends State


func enter() -> void:
	animation_player.stop()


func update(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		switch_states("attack")
	if parent.direction:
		switch_states("walk")
