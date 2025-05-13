extends Node2D

const PickUp = preload("res://elements/pickup/pickup.tscn")

@onready var player: Player = %Player
@onready var inventory_interface: Control = $UIRoot/InventoryInterface

func _ready() -> void:
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)

func toggle_inventory_interface(external_inventory_owner = null):
	inventory_interface.visible = !inventory_interface.visible
	
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
	else:
		inventory_interface.clear_external_inventory()


func _on_inventory_interface_drop_slot_data(slot_data: SlotData) -> void:
	var pickup = PickUp.instantiate()
	pickup.slot_data = slot_data
	pickup.position = player.get_drop_position()
	add_child(pickup)
