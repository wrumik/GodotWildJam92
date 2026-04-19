extends CanvasLayer

var in_game: bool = false:
	set(value):
		in_game = value
		%Hearts.visible = in_game


func _ready() -> void:
	set_can_attack(false)
	
	KeyActions.keybinds_updated.connect(func(): 
		var action = KeyActions.get_action(&"attack")
		$Control/VBoxContainer/AttackInstruction/Label.text = action.display_name + ": " + KeyActions.get_key_string_from_code(action.keycode)
		)


func set_can_attack(can_attack: bool) -> void:
	%AttackInstruction.visible = can_attack
	

func update_keys(amount: int) -> void:
	for c in %KeyLayout.get_children():
		c.queue_free()
		
	for i in amount:
		var rect= TextureRect.new()
		rect.texture = preload("res://src/sprites/key.png")
		rect.material = ShaderMaterial.new()
		rect.material.shader = preload("res://src/shaders/outline.gdshader")
		%KeyLayout.add_child(rect)
	
	
func update_max_health(new_max: int) -> void:
	for c in %Hearts.get_children():
		c.queue_free()
	
	var heart_scn = preload("res://src/scenes/heart_container.tscn")
	for x in round(float(new_max) / 2):
		%Hearts.add_child(heart_scn.instantiate())


func set_health(health: int) -> void:
	var count = health
	for c in %Hearts.get_children():
		if count >= 2:
			c.state = HeartContainer.HeartState.FULL
			count -= 2
		elif count == 1:
			c.state = HeartContainer.HeartState.HALF
			count -= 1
		else:
			c.state = HeartContainer.HeartState.EMPTY
