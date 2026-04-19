extends Control

@onready var title_label: Label = $MarginContainer/TitleLabel
@onready var options_menu: Control = $MarginContainer/OptionsMenu
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var credits_menu: Control = $MarginContainer/CreditsMenu

var is_option_menu_open: bool = false
var is_credit_menu_open: bool = false
var volume_offset: float = 6.0

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://src/scenes/main.tscn")
	SoundManager.play_sfx(Sounds.UI_FORWARD)


func _on_options_button_pressed():
	SoundManager.play_sfx(Sounds.UI_FORWARD)
	if is_option_menu_open:
		return
	
	is_option_menu_open = true
	
	if is_credit_menu_open:
		animation_player.play("credits_menu_close")
		await animation_player.animation_finished
		is_credit_menu_open = false
	
	animation_player.play("options_menu_open")


func _on_credits_button_pressed():
	SoundManager.play_sfx(Sounds.UI_FORWARD)
	if is_credit_menu_open:
		return
	
	is_credit_menu_open = true
	
	if is_option_menu_open:
		animation_player.play("options_menu_close")
		await animation_player.animation_finished
		is_option_menu_open = false
	
	animation_player.play("credits_menu_open")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_master_volume_slider_value_changed(value: float) -> void:
	if value == 0:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
	
	SoundManager.play_sfx(Sounds.UI_FORWARD)
	AudioServer.set_bus_volume_db(0, value - volume_offset)


func _on_sfx_volume_slider_value_changed(value: float) -> void:
	if value == 0:
		AudioServer.set_bus_mute(1, true)
	else:
		AudioServer.set_bus_mute(1, false)
	
	SoundManager.play_sfx(Sounds.UI_FORWARD)
	AudioServer.set_bus_volume_db(1, value - volume_offset)


func _on_music_volume_slider_value_changed(value: float) -> void:
	if value == 0:
		AudioServer.set_bus_mute(2, true)
	else:
		AudioServer.set_bus_mute(2, false)
	
	SoundManager.play_sfx(Sounds.UI_FORWARD)
	AudioServer.set_bus_volume_db(2, value - volume_offset)


func _on_back_button_pressed():
	SoundManager.play_sfx(Sounds.UI_BACKWARD)
	if is_option_menu_open:
		animation_player.play("options_menu_close")
	if is_credit_menu_open:
		animation_player.play("credits_menu_close")


func _ready() -> void:
	PlayerUI.in_game = false
