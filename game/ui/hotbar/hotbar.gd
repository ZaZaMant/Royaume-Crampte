extends Control

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var grid_container: GridContainer = $GridContainer
#
#func _ready() -> void:
	#print(player.hand_equiped)
	#if player:
		#for button in grid_container.get_children():
			#if button is HotbarItemButton:
				#button.hand_equip = player.hand_equiped
