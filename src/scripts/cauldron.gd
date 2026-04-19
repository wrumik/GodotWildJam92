class_name Cauldron
extends StaticBody2D

@export var ingredients_to_win: int = 4

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func collect_ingredient(_ingredient: Ingredient):
	animation_player.play("collected_ingredient")
	GameData.ingredients_collected += 1
	
	if GameData.ingredients_collected >= ingredients_to_win:
		# WIN!
		pass
	else:
		SoundManager.play_sfx(Sounds.DELIVER_INGREDIENT)
