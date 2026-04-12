class_name MapChunk
extends TileMapLayer

@export var exits_dict: Dictionary[String, PackedScene]

var size_rect: Rect2i
var size: Vector2
var neighboring_chunks: Array[MapChunk]


func _ready() -> void:
	# size is used for knowing where to place the next map chunk
	size_rect = get_used_rect()
	size = size_rect.size * tile_set.tile_size


func load_chunk(chunk_key: String, chunk_direction: ChunkDirectionsEnum.chunk_directions):
	var chunk_instance: MapChunk 
	if exits_dict.has(chunk_key):
		chunk_instance = exits_dict[chunk_key].instantiate()
	else:
		printerr("No level key found")
		return
	
	add_sibling(chunk_instance)
	
	# position the map chunk
	match chunk_direction:
		ChunkDirectionsEnum.chunk_directions.LEFT:
			chunk_instance.global_position = global_position - Vector2(chunk_instance.size.x, 0)
			print(global_position - Vector2(chunk_instance.size.x, 0))
		ChunkDirectionsEnum.chunk_directions.RIGHT:
			chunk_instance.global_position = global_position + Vector2(size.x, 0)
		ChunkDirectionsEnum.chunk_directions.UP:
			chunk_instance.global_position = global_position - Vector2(0, size.y)
		ChunkDirectionsEnum.chunk_directions.DOWN:
			chunk_instance.global_position = global_position + Vector2(0, chunk_instance.size.y)
	
