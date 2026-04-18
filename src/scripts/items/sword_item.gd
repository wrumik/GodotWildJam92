extends Item

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func use():
	var attack_direction = Vector2.ZERO
	if holder.last_direction.x > 0:
		animation_player.play("swing_right")
		attack_direction = Vector2.RIGHT
	if holder.last_direction.x < 0:
		animation_player.play("swing_left")
		attack_direction = Vector2.LEFT
	if holder.last_direction.y > 0:
		animation_player.play("swing_down")
		attack_direction = Vector2.DOWN
	if holder.last_direction.y < 0:
		animation_player.play("swing_up")
		attack_direction = Vector2.UP
	SoundManager.play_sfx(Sounds.SWORD_SWOOSH)
	$RotatingMeleeAttack.try_attack_dir(attack_direction)
	

func _on_attack_range_body_entered(body: Node2D) -> void:
	print(body)
