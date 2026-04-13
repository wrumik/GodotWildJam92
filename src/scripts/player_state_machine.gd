class_name PlayerStateMachine
extends CharacterBody2D

@onready var states: Node = $States
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var down_collision_check: RayCast2D = $DownCollisionCheck
@onready var left_collision_check: RayCast2D = $LeftCollisionCheck
@onready var right_collision_check: RayCast2D = $RightCollisionCheck
@onready var up_collision_check: RayCast2D = $UpCollisionCheck

@export var initial_state: State

const SPEED: float = 90.0

var states_dict: Dictionary[String, State]
var current_state: State

var target_position: Vector2
var direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.DOWN

var held_item: ItemResource = null


func _ready() -> void:
	target_position = global_position
	
	current_state = initial_state
	# append states for use when switching
	for state in states.get_children():
		states_dict.set(state.name.to_lower(), state)
		state.switch_state.connect(change_state)
		state.animation_player = animation_player
		state.parent = self


## changes the state of the character use switch_states(new_state_name: String) function
## or switch_state(old_state: State, new_state_name: String) signal
func change_state(old_state: State, new_state_name: String):
	var next_state: State = states_dict[new_state_name.to_lower()]
	#redundancy check
	if old_state == next_state:
		print("new state is the same as old state")
		return
	
	old_state.exit()
	current_state = next_state
	current_state.enter()


func _process(delta: float) -> void:
	current_state.update(delta)


func _physics_process(delta: float) -> void:
	if direction:
		last_direction = direction
	
	current_state.physics_update(delta)
	
	global_position = global_position.move_toward(target_position, SPEED * delta)


func _unhandled_input(_event: InputEvent) -> void:
	direction = Input.get_vector("left","right","up","down")
