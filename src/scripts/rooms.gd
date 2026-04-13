extends Node2D


func _ready() -> void:
	for c in get_children():
		if c is RoomRect:
			c.room_entered.connect(_on_room_entered.bind(c))
			
func _on_room_entered(rect: RoomRect) -> void:
	print("entered: ", rect)
	var bounds = rect.global_bounds()
	%Camera2D.limit_top = bounds.position.y
	%Camera2D.limit_left = bounds.position.x
	%Camera2D.limit_bottom = bounds.end.y
	%Camera2D.limit_right = bounds.end.x
