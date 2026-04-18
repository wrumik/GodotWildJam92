extends State

func enter() -> void:
	animation_player.animation_finished.connect(func(_name: String):
		if _name == "get_item":
			switch_states("idle"))
	animation_player.play("get_item")
