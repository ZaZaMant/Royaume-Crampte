extends StaticBody2D

@export var inventory_data: InventoryData

signal toggle_inventory(external_inventory_owner)

func player_interact(player: Player):
	toggle_inventory.emit(self)
