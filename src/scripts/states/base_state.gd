class_name State
extends Node

signal switch_state(old_state: State, new_state_name: String)

# these don't have to be assigned manually if the state machine assings those when appending to dict
@export var animation_player: AnimationPlayer
@export var parent: Node2D

func enter() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass

func exit() -> void:
	pass


func switch_states(new_state_name: String):
	switch_state.emit(self, new_state_name.to_lower())
