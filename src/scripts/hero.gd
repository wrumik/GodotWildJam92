extends CharacterBody2D

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite

const SPEED: float = 100.0


func _process(delta: float) -> void:
	# might want to change the movement so the player can't walk diagonally and
	# can only walk a set distance / grid based for that retro feel
	var direction: Vector2 = Input.get_vector("left","right","up","down")
	if direction:
		velocity = direction * SPEED * delta
		handle_animation(direction)
	else:
		velocity = Vector2.ZERO
	
	move_and_collide(velocity)


func handle_animation(dir):
	# magic numbers for checking player direction
	if sign(dir.x) == 1:
		player_sprite.play("walk_right")
	if sign(dir.x) == -1:
		player_sprite.play("walk_left")
	if sign(dir.y) == -1:
		player_sprite.play("walk_up")
	if sign(dir.y) == 1:
		player_sprite.play("walk_down")
