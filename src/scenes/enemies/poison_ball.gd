extends Area2D

@export var speed: int = 100
@export var damage: int = 1

var direction: Vector2= Vector2.ZERO


func _physics_process(delta: float) -> void:
	global_position += direction.normalized() * speed * delta
	%Pivot.rotation = direction.angle()


func _on_lifetime_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		area.damage(damage)
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is BreakableBody or body is TileMapLayer:
		queue_free()
