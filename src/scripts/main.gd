extends Node2D

@export var starting_dialogue_resource: DialogueResource

@onready var dead: Sprite2D = %Dead
@onready var grown: Sprite2D = %Grown

func _ready() -> void:
	PlayerUI.in_game = true
	DialogueManager.show_dialogue_balloon(starting_dialogue_resource)
