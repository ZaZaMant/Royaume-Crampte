extends CanvasLayer

@onready var player: CharacterBody2D = %Player
@onready var inventory_panel: InventoryDialog = %InventoryPanel


func _process(delta: float) -> void:

func _unhandled_input(event: InputEvent) -> void:
	
	# Open the inventory panel
	if event.is_action_released("inventory"):
		inventory_panel.toggle_visibility(player.inventory)
