class_name Cauldron
extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func collected_ingredient():
	animation_player.play("collected_ingredient")
