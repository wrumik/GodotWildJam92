class_name Snake
extends Enemy

var shoot_target: Node2D = null

func _ready() -> void:
	%MoveTarget.top_level = true
	

func _process(_delta: float) -> void:
	if shoot_target:
		var flip: bool = shoot_target.global_position.x > global_position.x
		$Sprite.flip_h = flip
		$PoisonPivot.scale.x = -1 if flip else 1
		


func check_target() -> void:
	for b in $Vision.get_overlapping_bodies():
		if b is PlayerStateMachine:
			%MoveTarget.global_position = global_position - (b.global_position - global_position)
			target = %MoveTarget
			shoot_target = b
			return


func attack() -> void:
	if $ShootCooldown.is_stopped():
		$ShootCooldown.start()
		$AnimationPlayer.play("pre_attack")
		await $AnimationPlayer.animation_finished
		
		$AnimationPlayer.play("idle")
		var ball = preload("res://src/scenes/enemies/poison_ball.tscn").instantiate()
		get_parent().add_child(ball)
		ball.global_position = %PoisonOrigin.global_position
		ball.direction = global_position.direction_to(shoot_target.global_position)
		
