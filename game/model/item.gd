class_name Item
extends Resource

@export var name: String
@export_multiline var description: String = ""
@export var stackable: bool = false
@export var texture: Texture2D
@export var price = 2

func use(target) -> void:
	pass
