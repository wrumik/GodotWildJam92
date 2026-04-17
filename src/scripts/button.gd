extends Area2D

@export var affected_node: Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D


func _on_body_entered(_body: Node2D) -> void:
	print("entered")
	affected_node.call_deferred("activate")
	sprite_2d.frame = 1


func _on_body_exited(_body: Node2D) -> void:
	affected_node.call_deferred("deactivate")
	sprite_2d.frame = 0
