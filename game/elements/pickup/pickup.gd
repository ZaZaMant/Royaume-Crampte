extends Node2D

@export var slot_data: SlotData

@onready var item_icon: Sprite2D = $ItemIcon

func _ready() -> void:
	item_icon.texture = slot_data.item_data.texture

func player_interact(player: Player):
	player.inventory_data.pick_up_slot_data(slot_data)
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
	#if body.inventory_data.pick_up_slot_data(slot_data):
		#queue_free()
