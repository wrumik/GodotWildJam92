class_name HurtBox
extends Area2D

signal damage_taken(amount: int)
signal damage_healed(amount: int)
signal destroyed()

@export var max_health: int = 1

@onready var current_health = max_health


func damage(amount: int) -> void:
	if amount < 0:
		heal(-amount)
	
	current_health = max(0, current_health - amount)
	damage_taken.emit(amount)
	if current_health == 0:
		destroyed.emit()
		
	
func heal(amount: int) -> void:
	if amount < 0:
		damage(-amount)
	
	current_health = min(max_health, current_health + amount)
	damage_healed.emit(amount)
