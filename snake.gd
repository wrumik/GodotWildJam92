class_name Snake
extends Enemy

var shoot_target: Node2D = null

@export var is_super: bool = false

func _ready() -> void:
	%MoveTarget.top_level = true
	

func _process(_delta: float) -> void:
	if shoot_target:
		var flip: bool = shoot_target.global_position.x > global_position.x
		$Sprite.flip_h = flip
		$PoisonPivot.scale.x = -1 if flip else 1
	
	if not "pre_attack" in $AnimationPlayer.current_animation:
		if Vector2i(global_position) == $GridMover.current_target:
			play_anim("idle")
		else:
			play_anim("move")


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
		play_anim("pre_attack")
		await $AnimationPlayer.animation_finished
		
		play_anim("idle")
		var ball = preload("res://src/scenes/enemies/poison_ball.tscn").instantiate()
		get_parent().add_child(ball)
		ball.global_position = %PoisonOrigin.global_position
		ball.direction = global_position.direction_to(shoot_target.global_position)
		
func play_anim(anim: String) -> void:
	if is_super:
		$AnimationPlayer.play("super_" + anim)
	else:
		$AnimationPlayer.play(anim)
