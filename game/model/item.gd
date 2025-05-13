class_name Item
extends Resource

@export var name: String
@export_multiline var description: String = ""
@export var stackable: bool = false
@export_flags("consumable", "weapon", "craft_item") var type = 0
@export var texture: Texture2D
@export var price = 2
