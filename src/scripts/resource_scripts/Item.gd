class_name ItemResource
extends Resource

@export var item_scene: PackedScene
@export var item_type: item_types

enum item_types {
	WEAPON,
	CONSUMABLE
}
