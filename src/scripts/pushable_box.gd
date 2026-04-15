extends BreakableBody

@onready var cast_down: RayCast2D = $CastDown
@onready var cast_left: RayCast2D = $CastLeft
@onready var cast_right: RayCast2D = $CastRight
@onready var cast_up: RayCast2D = $CastUp

var target_position: Vector2
var move_speed: float = 10.0
var cell_size: int = 16


func _ready() -> void:
	target_position = global_position


func destroy(attack_direction: Vector2):
	match attack_direction:
		Vector2.RIGHT:
			if cast_right.is_colliding():
				queue_free()
		Vector2.LEFT:
			if cast_left.is_colliding():
				queue_free()
		Vector2.UP:
			if cast_up.is_colliding():
				queue_free()
		Vector2.DOWN:
			if cast_down.is_colliding():
				queue_free()
	target_position += attack_direction * cell_size


func _physics_process(delta: float) -> void:
	global_position = lerp(global_position, target_position, move_speed * delta)
