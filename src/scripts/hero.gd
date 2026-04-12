class_name Player
extends CharacterBody2D

@onready var player_sprite: AnimatedSprite2D = $PlayerSprite
@onready var down_cast: RayCast2D = $DownCast
@onready var left_cast: RayCast2D = $LeftCast
@onready var right_cast: RayCast2D = $RightCast
@onready var up_cast: RayCast2D = $UpCast


const SPEED: float = 80.0

var direction: Vector2 = Input.get_vector("left","right","up","down")
var last_direction: Vector2 = Vector2.ZERO
var is_attacking: bool = false
var target_position: Vector2
var colliding_body: Node2D


func _ready() -> void:
	target_position = global_position


func _process(delta: float) -> void:
	direction = Input.get_vector("left","right","up","down")
	
	# Can't think of a better way to make the player move exactly 8 pixels at a time
	# that also accounts for wall collisions
	if !is_attacking && global_position == target_position:
		if direction.x > 0 && !right_cast.is_colliding():
			last_direction = direction
			update_animation()
			target_position.x += 8
		elif direction.x < 0 && !left_cast.is_colliding():
			last_direction = direction
			update_animation()
			target_position.x -= 8
		elif direction.y > 0 && !down_cast.is_colliding():
			last_direction = direction
			update_animation()
			target_position.y += 8
		elif direction.y < 0 && !up_cast.is_colliding():
			last_direction = direction
			update_animation()
			target_position.y -= 8
	
	
	global_position = global_position.move_toward(target_position, SPEED * delta)
	
	move_and_slide()


func update_animation():
	# magic numbers for checking player direction and setting the raycast position
	if !is_attacking: #player walk checks
		if sign(last_direction.x) == 1:
			player_sprite.play("walk_right")
		elif sign(last_direction.x) == -1:
			player_sprite.play("walk_left")
		elif sign(last_direction.y) == -1:
			player_sprite.play("walk_up")
		elif sign(last_direction.y) == 1:
			player_sprite.play("walk_down")
		if direction == Vector2.ZERO:
			player_sprite.stop()
	else: #player attack checks
		if sign(last_direction.y) == -1:
			player_sprite.play("attack_up")
		elif sign(last_direction.y) == 1:
			player_sprite.play("attack_down")
		elif sign(last_direction.x) == 1:
			player_sprite.play("attack_right")
		elif sign(last_direction.x) == -1:
			player_sprite.play("attack_left")
		await player_sprite.animation_finished
		is_attacking = false
		update_animation()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		direction = Input.get_vector("left","right","up","down")
		if Input.is_action_just_pressed("attack"):
			is_attacking = true
			update_animation()
