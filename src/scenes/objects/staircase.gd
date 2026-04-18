@tool
class_name Staircase
extends Area2D

enum Direction {
	UP,
	DOWN,
}

@export var other_side: Staircase

@export var up_sprite: Texture2D
@export var down_sprite: Texture2D

@export var direction: Direction = Direction.UP:
	set(value):
		direction = value
		if is_inside_tree():
			match direction:
				Direction.UP:
					%Sprite.texture = up_sprite
				Direction.DOWN:
					%Sprite.texture = down_sprite


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		if not other_side:
			return
			
		for b in get_overlapping_bodies():
			if b is PlayerStateMachine:
				b.global_position = other_side.global_position
				b.target_position = b.global_position
				b.teleporting = true
