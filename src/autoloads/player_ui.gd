extends CanvasLayer


func _ready() -> void:
	set_can_attack(false)

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
		
