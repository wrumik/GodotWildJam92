extends Node2D

## amount of pixels of movement that is required before the room can be switched again.
@export var room_switch_margin: int = 8

var first_time: bool = true
var tween: Tween = null

func _ready() -> void:
	%Camera2D.position_smoothing_enabled = false
	
	for c in get_children():
		if c is RoomRect:
			c.room_entered.connect(_on_room_entered.bind(c))
			
			
func _on_room_entered(_player: PlayerStateMachine, rect: RoomRect) -> void:
	var bounds = rect.global_bounds()
	
	var camera = %Camera2D
	var prev_pos = camera.get_screen_center_position()
	
	camera.limit_top = bounds.position.y
	camera.limit_left = bounds.position.x
	camera.limit_bottom = bounds.end.y
	camera.limit_right = bounds.end.x
	
	if first_time:
		first_time = false
		return
		
	if tween and tween.is_running():
		# Already entering the room means we dont have to animate it twice
		tween.stop()
		camera.offset = Vector2.ZERO
	
	camera.offset = prev_pos - camera.get_screen_center_position()
	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(camera, "offset", Vector2.ZERO, 0.6)
