class_name GridMover
extends Node

@export var body: CharacterBody2D
@export var grid_size: int = 8
@export var move_speed: float = 65.0
@export var ignore_grid: bool = false

var direction: Vector2i = Vector2.ZERO
var current_target: Vector2i = Vector2.ZERO


func _ready() -> void:
	if not body:
		return
		
	assert(body)
	
	body.global_position = body.global_position.snapped(Vector2(grid_size, grid_size))
	current_target = body.global_position


func _physics_process(delta: float) -> void:
	if not body or ignore_grid:
		return
		
	var can_move = Vector2i(body.global_position) == current_target
	
	if can_move:
		current_target += direction * grid_size
	
	body.global_position = body.global_position.move_toward(current_target, move_speed * delta)


static func dir_to_cardinal(dir: Vector2) -> Vector2i:
	var angle = fposmod(dir.angle(), TAU)
	if angle < 1 * (PI/4):
		return Vector2i.RIGHT
	elif angle < 3 * (PI/4):
		return Vector2i.DOWN
	elif angle < 5 * (PI/4):
		return Vector2i.LEFT
	elif angle < 7 * (PI/4):
		return Vector2i.UP
	else:
		return Vector2i.RIGHT
	

func pick_direction(to: Vector2) -> void:
	if not body:
		return
		
	if to == body.global_position:
		direction = Vector2i.ZERO
		return
	
	var raw_dir = body.global_position.direction_to(to)
	direction = dir_to_cardinal(raw_dir)
