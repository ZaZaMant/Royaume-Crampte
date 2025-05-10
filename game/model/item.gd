class_name Item
extends Resource

@export var name: String
@export_flags("consumable", "weapon", "craft_item") var type = 0
@export var icon: Texture2D
@export var price = 2
