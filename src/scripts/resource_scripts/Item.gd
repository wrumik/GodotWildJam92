class_name ItemResource
extends Resource

@export var item_scene: PackedScene
@export var item_type: item_types
@export var icon: Texture2D

# for now item type doesnt matter and will always be treated as weapon
enum item_types {
	WEAPON,
	CONSUMABLE,
	UPGRADE
}
