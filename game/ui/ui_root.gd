extends CanvasLayer

@onready var player: CharacterBody2D = %Player
@onready var inventory_panel: InventoryDialog = %PlayerInventoryPanel

# Player stats
@onready var player_health_bar: ProgressBar = %PlayerHealthBar
@onready var player_stamina_bar: ProgressBar = %PlayerStaminaBar
@onready var player_hunger_bar: HBoxContainer = %PlayerHungerBar

var health_component: HealthComponent

func _ready() -> void:
	player_stamina_bar.max_value = player.max_stamina

func _process(delta: float) -> void:
	health_component = player.get_node('HeathComponent')
	player_health_bar.max_value = health_component.max_health
	player_health_bar.value = health_component.health
	player_stamina_bar.value = player.stamina

#func _unhandled_input(event: InputEvent) -> void:
	## Open the inventory panel
	#if event.is_action_released("inventory"):
		#inventory_panel.toggle_visibility(player.inventory)
