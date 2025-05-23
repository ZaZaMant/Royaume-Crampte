extends Control

var grabbed_slot_data: SlotData
var external_inventory_owner

@onready var external_inventory_panel: InventoryDialog = %ExternalInventoryPanel
@onready var player_inventory_panel: InventoryDialog = %PlayerInventoryPanel
@onready var grabbed_item_slot: PanelContainer = $GrabbedItemSlot
@onready var weapon_inventory: InventoryDialog = %WeaponInventory

signal drop_slot_data(slot_data: SlotData)
signal force_close

func _physics_process(delta: float) -> void:
	if grabbed_item_slot.visible:
		grabbed_item_slot.global_position = get_global_mouse_position() + Vector2(5, 5)
	
	if external_inventory_owner \
		and external_inventory_owner.global_position.distance_to(PlayerManager.get_global_position()) > 24:
		force_close.emit()

func set_player_inventory_data(inventory_data: InventoryData):
	inventory_data.inventory_interact.connect(on_inventory_interact)
	player_inventory_panel.set_inventory_data(inventory_data)

func set_weapon_inventory_data(inventory_data: InventoryData):
	inventory_data.inventory_interact.connect(on_inventory_interact)
	weapon_inventory.set_inventory_data(inventory_data)

func set_external_inventory(_external_inventory_owner):
	external_inventory_owner = _external_inventory_owner
	var inventory_data = external_inventory_owner.inventory_data
	
	inventory_data.inventory_interact.connect(on_inventory_interact)
	external_inventory_panel.set_inventory_data(inventory_data)
	
	external_inventory_panel.show()
	
func clear_external_inventory():
	if external_inventory_owner:
		var inventory_data = external_inventory_owner.inventory_data
		
		inventory_data.inventory_interact.disconnect(on_inventory_interact)
		external_inventory_panel.clear_inventory_data(inventory_data)
		
		external_inventory_panel.hide()
		external_inventory_owner = null

func on_inventory_interact(inventory_data: InventoryData, index: int, button: int):
	match [grabbed_slot_data, button]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.grab_slot_data(index)
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_slot_data = inventory_data.drop_slot_data(grabbed_slot_data, index)
		[null, MOUSE_BUTTON_RIGHT]:
			inventory_data.use_slot_data(index)
		[_, MOUSE_BUTTON_RIGHT]:
			grabbed_slot_data = inventory_data.drop_single_slot_data(grabbed_slot_data, index)

	update_grabbed_slot()

func update_grabbed_slot():
	if grabbed_slot_data:
		grabbed_item_slot.show()
		grabbed_item_slot.set_slot_data(grabbed_slot_data)
	else:
		grabbed_item_slot.hide()

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	 	and event.is_pressed() \
		and grabbed_slot_data:

		match event.button_index:
			MOUSE_BUTTON_LEFT:
				drop_slot_data.emit(grabbed_slot_data)
				grabbed_slot_data = null
			MOUSE_BUTTON_RIGHT:
				drop_slot_data.emit(grabbed_slot_data.create_single_slot_data())
				if grabbed_slot_data.quantity < 1:
					grabbed_slot_data = null

		update_grabbed_slot()

func _on_visibility_changed() -> void:
	if not visible and grabbed_slot_data:
		drop_slot_data.emit(grabbed_slot_data)
		grabbed_slot_data = null

		update_grabbed_slot()
