extends Item

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func use():
	if holder.last_direction.x > 0:
		animation_player.play("swing_right")
	if holder.last_direction.x < 0:
		animation_player.play("swing_left")
	if holder.last_direction.y > 0:
		animation_player.play("swing_down")
	if holder.last_direction.y < 0:
		animation_player.play("swing_up")
