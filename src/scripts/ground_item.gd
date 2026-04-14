@tool
class_name GroundItem
extends Area2D

@export var item: ItemResource:
	set(value):
		item = value
		if is_node_ready():
			if is_instance_valid(item):
				$Sprite2D.texture = item.icon
			else:
				$Sprite2D.texture = null


func _on_body_entered(body: Node2D) -> void:
	if body is PlayerStateMachine:
		body.grab_item(item)
		queue_free()


func _ready() -> void:
	if item:
		$Sprite2D.texture = item.icon
