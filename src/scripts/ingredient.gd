class_name Ingredient
extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var ingredient_sprite: Texture2D
@onready var collider: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	sprite_2d.texture = ingredient_sprite
	%Label.text = "Pick Up: " + KeyActions.get_key_string_from_code(KeyActions.get_action("pickup").keycode)
	KeyActions.keybinds_updated.connect(
		func(): 
			%Label.text = "Pick Up: " + KeyActions.get_key_string_from_code(KeyActions.get_action("pickup").keycode)
			)


func _physics_process(_delta: float) -> void:
	for a in %Area.get_overlapping_bodies():
		if a is PlayerStateMachine and not a.is_holding_ingredient:
			%Label.visible = true
			return
			
	%Label.visible = false
