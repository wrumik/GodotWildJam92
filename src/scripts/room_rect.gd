class_name RoomRect
extends Node2D

signal room_entered(body: PlayerStateMachine)
signal room_exited(body: PlayerStateMachine)

@export var inside: bool = true

var navigation_grid: AStarGrid2D = null # :
	#set(value):
		#navigation_grid = value
		#queue_redraw()

## NAV DEBUG
#func _draw() -> void:
	#
	#if not navigation_grid:
		#return
		#
	#var color = Color(randf(), randf(), randf(), 1.0)
	#for x in range(navigation_grid.region.position.x, navigation_grid.region.end.x):
		#for y in range(navigation_grid.region.position.y, navigation_grid.region.end.y):
			#if navigation_grid.is_point_solid(Vector2i(x, y)):
				#draw_circle(Vector2(x, y) * 16 + Vector2(8, 8), 4, color, true)
			#else:
				#draw_circle(Vector2(x, y) * 16 + Vector2(8, 8), 5, color, false, 2)

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
		if c is EnemyHolder:
			c.spawn(self)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is not PlayerStateMachine:
		return
	
	room_exited.emit(body)
	
	for c in %RoomObjects.get_children():
		if c is EnemyHolder:
			c.reset()


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
	#for c in %RoomObjects.get_children():
		#if c is EnemyHolder:
			#c.spawn(self)
	pass
			

func get_navigation_path(from_global: Vector2, target_global: Vector2) -> PackedVector2Array:
	var bounds = global_bounds()
	if not bounds.has_point(from_global) or not bounds.has_point(target_global):
		return []
	
	var local_start = round((from_global - Vector2(8, 8)) / navigation_grid.cell_size)
	var local_end: Vector2 = round((target_global - Vector2(8, 8)) / navigation_grid.cell_size)
	local_end = local_end.clamp(bounds.position, bounds.end)
	var points = navigation_grid.get_point_path(local_start, local_end, true)
	return points
