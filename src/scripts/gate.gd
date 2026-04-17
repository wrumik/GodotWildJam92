extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func activate():
	sprite_2d.frame = 1
	collision_shape_2d.disabled = true


func deactivate():
	sprite_2d.frame = 0
	collision_shape_2d.disabled = false
