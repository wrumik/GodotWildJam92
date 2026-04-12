extends Area2D

const ChunkDirections: Script = preload("res://src/enums/direction_enum.gd")

@export var scene_key: String = ""
@export var map_chunk: MapChunk
@export var chunk_direction: ChunkDirectionsEnum.chunk_directions

func _ready() -> void:
	# map_chunk not set failsafe
	map_chunk = get_parent()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		map_chunk.load_chunk(scene_key, chunk_direction)
