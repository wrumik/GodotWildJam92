extends Node

var ingredients_collected: int = 0

func _process(delta: float) -> void:
	if ingredients_collected >= 4:
		get_tree().change_scene_to_file("res://src/scenes/game_end_scene.tscn")
