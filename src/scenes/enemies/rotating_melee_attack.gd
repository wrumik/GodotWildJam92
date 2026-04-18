class_name RotatingMeleeAttack
extends Node2D

@export var damage: int = 1

var target_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	%CollisionShape2D.disabled = true
	
	
func try_attack_dir(dir: Vector2, skip_cd: bool = true) -> bool:
	look_at(global_position + (dir * 10))
	target_direction = dir.normalized()
	
	if not %AttackCooldown.is_stopped() and not skip_cd:
		return false
	
	%AttackCooldown.start()
	
	%CollisionShape2D.disabled = false
	look_at(global_position + (dir * 10))
	await get_tree().physics_frame
	await get_tree().physics_frame
	attack_started()
	return true


func try_attack(target: Vector2) -> bool:
	look_at(target)
	target_direction = global_position.direction_to(target)
	
	if not %AttackCooldown.is_stopped():
		return false
	
	%AttackCooldown.start()

	%CollisionShape2D.disabled = false
	look_at(target)
	get_tree().create_timer(0.3).timeout.connect(attack_started)
	return true


func attack_started() -> void:
	for a in %AttackRange.get_overlapping_areas():
		if a is HurtBox:
			a.damage(damage)
	
	for a in %AttackRange.get_overlapping_bodies():
		if a is BreakableBody:
			a.destroy(target_direction)

	%CollisionShape2D.disabled = true
