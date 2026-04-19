class_name SpeedArea
extends Area2D

@export var speed_reduction_multiplier: float = 0.4

var bodies = []

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("add_speed_area"):
		body.add_speed_area(self)
		bodies.append(body)


func reset_bodies() -> void:
	for body in bodies:
		if body.has_method("remove_speed_area"):
			body.remove_speed_area(self)
	
	bodies.clear()
		
func _exit_tree() -> void:
	reset_bodies()
	

func _on_body_exited(body: Node2D) -> void:
	if body in bodies:
		if body.has_method("remove_speed_area"):
			body.remove_speed_area(self)
		bodies.erase(body)
