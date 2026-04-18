class_name PlayerStateMachine
extends CharacterBody2D

@onready var states: Node = $States
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var down_collision_check: ShapeCast2D = $DownCollisionCheck
@onready var left_collision_check: RayCast2D = $LeftCollisionCheck
@onready var right_collision_check: RayCast2D = $RightCollisionCheck
@onready var up_collision_check: ShapeCast2D = $UpCollisionCheck
@onready var interaction_cast: RayCast2D = $InteractionCast

@export var initial_state: State

@export var base_speed: float = 90.0 + 100
@export var grass: TileMapLayer = null
@onready var speed: float = base_speed

var states_dict: Dictionary[String, State]
var current_state: State

var target_position: Vector2
var direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.DOWN

var item_instance: Item = null

var is_holding_ingredient: bool = false
var held_ingredient: Ingredient

var keys: int = 0:
	set(value):
		keys = value
		PlayerUI.update_keys(keys)

var teleporting: bool = false


# state machine related functions
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
	
	global_position = global_position.move_toward(target_position, speed * delta)
	
	if held_ingredient:
		held_ingredient.global_position = $IngredientPosition.global_position


func play_step_sound():
	if grass and grass.local_to_map(grass.to_local(self.global_position)) in grass.get_used_cells():
		SoundManager.play_random_sfx(Sounds.FOOTSTEP_GRASS, 0.5)
	else:
		SoundManager.play_sfx(Sounds.FOOTSTEP, 0.5, randf_range(0.7, 1.0))


func _unhandled_input(_event: InputEvent) -> void:
	direction = Input.get_vector("left","right","up","down")


#item related functions
func grab_item(item: ItemResource):
	$NewItem.texture = item.icon
	current_state.switch_states("ItemGet")
	SoundManager.play_sfx(Sounds.GAIN_ITEM)
	
	if item.item_type == ItemResource.item_types.UPGRADE:
		var temp_item: Item = item.item_scene.instantiate()
		add_child(temp_item)
		temp_item.holder = self
		temp_item.picked_up()
		return
		
	if item.item_type == ItemResource.item_types.KEY:
		keys += 1
		return
	
	if item_instance:
		item_instance.queue_free()
	
	item_instance = item.item_scene.instantiate()
	add_child.call_deferred(item_instance)
	item_instance.holder = self
	item_instance.picked_up()
	
	PlayerUI.set_can_attack(item.item_type == ItemResource.item_types.WEAPON)


func pickup_ingredient():
	if interaction_cast.get_collider() is not Ingredient:
		return
	
	#$NewItem.texture = interaction_cast.get_collider().ingredient_sprite
	#current_state.switch_states("ItemGet")
	SoundManager.play_sfx(Sounds.GAIN_ITEM)
	is_holding_ingredient = true
	held_ingredient = interaction_cast.get_collider()

func drop_ingredient() -> bool:
	if interaction_cast.is_colliding():
		return false
	
	is_holding_ingredient = false
	held_ingredient.global_position = interaction_cast.global_position + interaction_cast.target_position * 2
	held_ingredient = null
	return true


func _on_hurt_box_damage_taken(_amount: int) -> void:
	%HitEffect.play("hit")


func _on_hurt_box_destroyed() -> void:
	get_tree().reload_current_scene()
