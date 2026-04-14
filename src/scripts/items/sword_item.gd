extends Item

@onready var animation_player: AnimationPlayer = $AnimationPlayer
# COULD PROBABLY USE AN AREA2D INSTEAD OF ALL THESE RAYCASTS BUT FOR NOW THIS WORKS
@onready var attack_down_cast: RayCast2D = $AttackDownCast
@onready var attack_up_cast: RayCast2D = $AttackUpCast
@onready var attack_left_cast: RayCast2D = $AttackLeftCast
@onready var attack_right_cast: RayCast2D = $AttackRightCast


func use():
	if holder.last_direction.x > 0:
		animation_player.play("swing_right")
		if attack_right_cast.get_collider() is BreakableBody:
			attack_right_cast.get_collider().destroy()
	if holder.last_direction.x < 0:
		animation_player.play("swing_left")
		if attack_left_cast.get_collider() is BreakableBody:
			attack_left_cast.get_collider().destroy()
	if holder.last_direction.y > 0:
		animation_player.play("swing_down")
		if attack_down_cast.get_collider() is BreakableBody:
			attack_down_cast.get_collider().destroy()
	if holder.last_direction.y < 0:
		animation_player.play("swing_up")
		if attack_up_cast.get_collider() is BreakableBody:
			attack_up_cast.get_collider().destroy()
