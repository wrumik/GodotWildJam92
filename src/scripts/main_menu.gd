extends Control

@onready var title_label: Label = $MarginContainer/TitleLabel
@onready var options_menu: Control = $MarginContainer/OptionsMenu

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")
	SoundManager.play_sfx(Sounds.GAIN_ITEM)


func _on_options_button_pressed():
	SoundManager.play_sfx(Sounds.UI_BACKWARD)
	$CanvasLayer/PauseMenu.pause()


func _on_credits_button_pressed():
	pass


func _on_quit_button_pressed():
	get_tree().quit()
