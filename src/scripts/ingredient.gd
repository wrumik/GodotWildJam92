class_name Ingredient
extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var ingredient_sprite: Texture2D


func _ready() -> void:
	sprite_2d.texture = ingredient_sprite
