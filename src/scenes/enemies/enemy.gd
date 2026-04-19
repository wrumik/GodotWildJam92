class_name Enemy
extends CharacterBody2D

@export var attack_range: int = 15
@export var min_target_dist: int = 30
@export var animator: Animator = null

var target: Node2D
var room: RoomRect
var points: PackedVector2Array = []
var active: bool = false

#func _draw() -> void:
	#if points.is_empty():
		#return
	#
	#for p in points:
		#draw_circle(to_local(p - Vector2(8, 8)), 2, Color.RED)


func _physics_process(_delta: float) -> void:
	if not active:
		return
		
	$GridMover.pick_direction(self.global_position)
		
	check_target()
	if can_attack():
		attack()
	
	if can_move():
		move()
	
	queue_redraw()
	
	
func _process(delta: float) -> void:
	if animator and target:
		animator.update($GridMover.direction, self.global_position.direction_to(target.global_position), delta)


func _on_hurt_box_destroyed() -> void:
	queue_free()


func can_attack() -> bool:
	return target and target.global_position.distance_to(global_position) <= attack_range
		

## Do not move when too close to the target
func can_move() -> bool:
	return target and target.global_position.distance_to(global_position) > min_target_dist
	
	
func move() -> void:
	assert(room, "I am not in a room!")
	if not target or not room:
		return
	
	points = room.get_navigation_path(self.global_position, target.global_position)
	var dist_sq = self.global_position.distance_squared_to(target.global_position)
	for p in points:
		if p.distance_squared_to(target.global_position) < dist_sq:
			$GridMover.pick_direction(p)
			return
	#$GridMover.pick_direction(pos)


func check_target() -> void:
	for b in $Vision.get_overlapping_bodies():
		if b is PlayerStateMachine:
			target = b
			return
	
	#target = null


func attack() -> void:
	if $RotatingMeleeAttack.try_attack(target.global_position):
		if animator:
			animator.play_attack()
