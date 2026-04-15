class_name RoomRect
extends Node2D

signal room_entered(body: PlayerStateMachine)
signal room_exited(body: PlayerStateMachine)

var navigation_grid: AStarGrid2D = null


func _ready() -> void:
	var bounds = global_bounds()
	$Area2D.show()
	%RoomShape.debug_color = Color(randf(), randf(), randf(), %RoomShape.debug_color.a)
	
	%RoomShape.shape.size = bounds.size
	%RoomShape.position = bounds.position + bounds.size / 2 


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is not PlayerStateMachine:
		return
	
	room_entered.emit(body)
	
	for c in %RoomObjects.get_children():
		c.active = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is not PlayerStateMachine:
		return
	
	room_exited.emit(body)
	
	for c in %RoomObjects.get_children():
		c.active = false


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


func setup() -> void:
	for c in %RoomObjects.get_children():
		if c is Enemy:
			c.room = self
			

func get_next_pos(from_global: Vector2, target_global: Vector2) -> Vector2:
	var bounds = global_bounds()
	if not bounds.has_point(from_global) or not bounds.has_point(target_global):
		return from_global
	
	var local_start = from_global / navigation_grid.cell_size
	var local_end = target_global / navigation_grid.cell_size
	var points = navigation_grid.get_point_path(local_start, local_end, true)
	if points.size() >= 2:
		return points[1]
	return from_global
