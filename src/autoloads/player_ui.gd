extends CanvasLayer


func _ready() -> void:
	set_can_attack(false)

func set_can_attack(can_attack: bool) -> void:
	%AttackInstruction.visible = can_attack
