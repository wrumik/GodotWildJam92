class_name RoomRect
extends Node2D

signal room_entered(body: PlayerStateMachine)
signal room_exited(body: PlayerStateMachine)

func _ready() -> void:
	var bounds = global_bounds()
	$Area2D.show()
	%RoomShape.debug_color = Color(randf(), randf(), randf(), %RoomShape.debug_color.a)
	
	%RoomShape.shape.size = bounds.size
	%RoomShape.position = bounds.position + bounds.size / 2 
	print(%RoomShape.position)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not PlayerStateMachine:
		return
	
	room_entered.emit(body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is not PlayerStateMachine:
		return
	
	room_exited.emit(body)


func global_bounds() -> Rect2:
	var global_min = Vector2()
	global_min.x = min(%Corner1.position.x, %Corner2.position.x)
	global_min.y = min(%Corner1.position.y, %Corner2.position.y)
	
	var global_max = Vector2()
	global_max.x = max(%Corner1.position.x, %Corner2.position.x)
	global_max.y = max(%Corner1.position.y, %Corner2.position.y)
	
	return Rect2(global_min, global_max - global_min)


func _to_string() -> String:
	return str(global_bounds())
