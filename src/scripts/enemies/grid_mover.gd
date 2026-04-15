class_name GridMover
extends Node

@export var body: CharacterBody2D
@export var grid_size: int = 8

var target_position: Vector2

func _ready() -> void:
	assert(body)
	
	body.global_position = body.global_position.snapped(Vector2(grid_size, grid_size))
	target_position = body.global_position
