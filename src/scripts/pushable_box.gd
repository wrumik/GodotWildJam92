class_name PushableBox
extends BreakableBody

@onready var cast_down: RayCast2D = $CastDown
@onready var cast_left: RayCast2D = $CastLeft
@onready var cast_right: RayCast2D = $CastRight
@onready var cast_up: RayCast2D = $CastUp
@onready var box_sprite: Sprite2D = $BoxSprite
@onready var box_collider: CollisionShape2D = $BoxCollider
@onready var box_break_particles: CPUParticles2D = $BoxBreakParticles

var target_position: Vector2
var move_speed: float = 10.0
var cell_size: int = 16

signal destroyed()

func _ready() -> void:
	target_position = global_position


# pushing logic is under destory() because it didn't make sense to make a separate class for this
# should've made a SwordInteraction class instead of BreakableObject 
func destroy(attack_direction: Vector2):
	match attack_direction:
		Vector2.RIGHT:
			if cast_right.is_colliding():
				destroy_box()
		Vector2.LEFT:
			if cast_left.is_colliding():
				destroy_box()
		Vector2.UP:
			if cast_up.is_colliding():
				destroy_box()
		Vector2.DOWN:
			if cast_down.is_colliding():
				destroy_box()
	target_position += attack_direction * cell_size
	

func destroy_box():
	SoundManager.play_sfx(Sounds.BOX_BROKEN)
	box_sprite.visible = false
	box_collider.disabled = true
	box_break_particles.emitting = true
	box_break_particles.finished.connect(func(): 
		destroyed.emit()
		queue_free())


func _physics_process(delta: float) -> void:
	global_position = lerp(global_position, target_position, move_speed * delta)


func check_spawn_pos() -> void:
	var collision: KinematicCollision2D = KinematicCollision2D.new()
	var collide = test_move(transform, Vector2.ZERO, collision)
	if collide:
		destroy_box()
