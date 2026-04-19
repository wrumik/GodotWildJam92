class_name EnemyHolder
extends Node2D

@export var enemy_to_spawn: PackedScene
@export var respawn: bool = true

var current_enemy: Enemy = null

var killed_once: bool = false

func spawn(room: RoomRect) -> void:
	if current_enemy:
		reset()
	
	if killed_once and not respawn:
		return
	
	current_enemy = enemy_to_spawn.instantiate()
	current_enemy.room = room
	await get_tree().physics_frame
	
	add_child(current_enemy)
	current_enemy.global_position = global_position
	current_enemy.active = true
	

func reset() -> void:
	if is_instance_valid(current_enemy) and current_enemy:
		current_enemy.active = false
		if is_inside_tree():
			# TODO: Poof effect on enemy position before despawning?
			await get_tree().create_timer(0.3).timeout
			if not current_enemy:
				return
			current_enemy.queue_free()
		else:
			killed_once = true
	else:
		killed_once = true
	current_enemy = null
