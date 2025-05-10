class_name Recipe
extends Resource

@export var name: String
@export_multiline var indices: Array[String] = [] # mmh here or somewhere else ?
@export var ingredients: Array[Item] = []
@export var results: Array[Item] = []
