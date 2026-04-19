extends Node2D

@export var starting_dialogue_resource: DialogueResource

func _ready() -> void:
	DialogueManager.show_dialogue_balloon(starting_dialogue_resource)
