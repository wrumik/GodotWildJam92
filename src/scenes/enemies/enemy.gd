class_name Enemy
extends CharacterBody2D

@export var attack_range: int = 15
@export var min_target_dist: int = 30
@export var speed: float = 65.0

var target: Node2D
var room: RoomRect
var active: bool = false


func _physics_process(_delta: float) -> void:
	if not active:
		return
		
	check_target()
	if can_attack():
		attack()
	
	if can_move():
		move()
	else:
		velocity = Vector2.ZERO
		

func _on_hurt_box_destroyed() -> void:
	queue_free()


func can_attack() -> bool:
	return target and target.global_position.distance_to(global_position) <= attack_range
		

## Do not move when too close to the target
func can_move() -> bool:
	return target and target.global_position.distance_to(global_position) > min_target_dist
	
	
func move() -> void:
	assert(room, "I am not in a room!")
	velocity = Vector2.ZERO
	if not target or not room:
		return
	
	var pos = room.get_next_pos(self.global_position, target.global_position)
	if pos == self.global_position:
		return
		
	var dir = self.global_position.direction_to(pos)
	velocity = dir * speed
	move_and_slide()


func check_target() -> void:
	for b in $Vision.get_overlapping_bodies():
		if b is PlayerStateMachine:
			target = b
			return
	
	target = null


func attack() -> void:
	print("IM ATTACKING YOU RN!")
