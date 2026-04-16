class_name GridMover
extends Node

@export var body: CharacterBody2D
@export var grid_size: int = 8
@export var move_speed: float = 65.0

var direction: Vector2i = Vector2.ZERO
var current_target: Vector2i = Vector2.ZERO
var angle: float = 0.0

func _ready() -> void:
	assert(body)
	
	body.global_position = body.global_position.snapped(Vector2(grid_size, grid_size))
	current_target = body.global_position


func _physics_process(delta: float) -> void:
	if not body:
		return
		
	var can_move = Vector2i(body.global_position) == current_target
	
	if can_move:
		current_target += direction * grid_size
	
	body.global_position = body.global_position.move_toward(current_target, move_speed * delta)


func pick_direction(to: Vector2) -> void:
	if to == body.global_position:
		direction = Vector2i.ZERO
		return
	
	var raw_dir = body.global_position.direction_to(to)
	angle = fposmod(raw_dir.angle(), TAU)
	if angle < 1 * (PI/4):
		direction = Vector2i.RIGHT
	elif angle < 3 * (PI/4):
		direction = Vector2i.DOWN
	elif angle < 5 * (PI/4):
		direction = Vector2i.LEFT
	elif angle < 7 * (PI/4):
		direction = Vector2i.UP
	else:
		direction = Vector2i.RIGHT
