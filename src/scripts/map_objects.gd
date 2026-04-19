extends Node2D

const BOX_SCN = preload("res://src/scenes/pushable_box.tscn")

var boxes = {}
@onready var rooms: Rooms = %Rooms

func _ready() -> void:
	for c in get_children():
		if c is PushableBox:
			c.destroyed.connect(_on_box_destroyed.bind(c.name))
			c.moved.connect(_on_box_moved)
			var pos = c.global_position
			boxes[c.name] = pos
	
	await get_parent().ready
	
	for pos in boxes.values():
		rooms.box_moved(pos, pos)


func _on_box_destroyed(box_name: String) -> void:
	if not box_name in boxes:
		return
		
	var spawn_pos = boxes[box_name]
	var box: PushableBox = BOX_SCN.instantiate()
	box.global_position = spawn_pos
	add_child(box)
	box.destroyed.connect(_on_box_destroyed.bind(box_name))
	
	await get_tree().physics_frame


func _on_box_moved(old_pos: Vector2, new_pos: Vector2) -> void:
	rooms.box_moved(old_pos, new_pos)
