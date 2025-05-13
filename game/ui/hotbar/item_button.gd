@tool
class_name HotbarItemButton
extends Button

@export var item: Item :
	set(item_to_slot):
		item = item_to_slot
		icon = item.texture

@onready var player: Player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	connect("pressed", _on_pressed)

func _process(delta: float) -> void:
	var stylebox = get_theme_stylebox("normal")
	if player:
		if player.hand_equiped == item:
			stylebox.bg_color = "#000"
	add_theme_stylebox_override("normal", stylebox)

func _on_pressed():
	if player:
		player.hand_equiped = item
