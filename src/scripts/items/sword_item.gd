extends Item

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attack_cast: RayCast2D = $AttackCast

func use():
	if holder.last_direction.x > 0:
		animation_player.play("swing_right")
	if holder.last_direction.x < 0:
		animation_player.play("swing_left")
	if holder.last_direction.y > 0:
		animation_player.play("swing_down")
	if holder.last_direction.y < 0:
		animation_player.play("swing_up")
	if attack_cast.get_collider() is BreakableBody:
		attack_cast.get_collider().destroy()
