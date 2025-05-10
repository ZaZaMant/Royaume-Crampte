extends Node2D

@export var item: Item

@onready var _item_icon: Sprite2D = $ItemIcon

func _ready() -> void:
	_item_icon.texture = item.icon

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("on_item_picked_up"):
		body.on_item_picked_up(item)
		
		# TODO - animation
		
		queue_free()
