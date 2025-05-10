class_name InventoryDialog
extends PanelContainer

@export var slot_scene: PackedScene

@onready var _grid_container: GridContainer = %GridContainer

var _is_opened = false

func open(inventory: Inventory):
	show()
	_is_opened = true
	
	# remove all items
	for child in _grid_container.get_children():
		child.queue_free()
	
	for item in inventory.get_item():
		var slot = slot_scene.instantiate()
		_grid_container.add_child(slot) # first add the slot
		slot.display(item) # then display the item

func close():
	hide()
	_is_opened = false

	# remove all items
	for child in _grid_container.get_children():
		child.queue_free()

func toggle_visibility(inventory: Inventory):
	if _is_opened:
		close()
	else:
		open(inventory)
	
