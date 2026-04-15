extends Item

@onready var animation_player: AnimationPlayer = $AnimationPlayer
# COULD PROBABLY USE AN AREA2D INSTEAD OF ALL THESE RAYCASTS BUT FOR NOW THIS WORKS
@onready var attack_down_cast: RayCast2D = $AttackDownCast
@onready var attack_up_cast: RayCast2D = $AttackUpCast
@onready var attack_left_cast: RayCast2D = $AttackLeftCast
@onready var attack_right_cast: RayCast2D = $AttackRightCast


func use():
	var collider = null
	if holder.last_direction.x > 0:
		animation_player.play("swing_right")
		collider = attack_right_cast.get_collider()
	if holder.last_direction.x < 0:
		animation_player.play("swing_left")
		collider = attack_left_cast.get_collider()
	if holder.last_direction.y > 0:
		animation_player.play("swing_down")
		collider = attack_down_cast.get_collider()
	if holder.last_direction.y < 0:
		animation_player.play("swing_up")
		collider = attack_up_cast.get_collider()

	if collider:
		if collider is BreakableBody:
			collider.destroy()
		elif collider is HurtBox:
			collider.damage(1)
