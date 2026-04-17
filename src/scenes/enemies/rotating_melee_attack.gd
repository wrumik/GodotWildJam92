class_name RotatingMeleeAttack
extends Node2D

@export var damage: int = 1


func _ready() -> void:
	%CollisionShape2D.disabled = true
	

func try_attack(target: Vector2) -> bool:
	look_at(target)
	
	if not %AttackCooldown.is_stopped():
		return false
	
	%AttackCooldown.start()
	
	%CollisionShape2D.disabled = false
	
	get_tree().physics_frame.connect(attack_started, CONNECT_ONE_SHOT)
	return true


func attack_started() -> void:
	for a in %AttackRange.get_overlapping_areas():
		if a is HurtBox:
			a.damage(damage)
	
	print("ATTACKED")
	%CollisionShape2D.disabled = true
