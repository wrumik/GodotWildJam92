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
	#TODO: the previous code was broken, new one is needed
	pass
