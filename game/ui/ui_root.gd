extends CanvasLayer

@onready var player: Player = %Player
@onready var inventory_panel: InventoryDialog = %PlayerInventoryPanel

# Player stats
@onready var player_health_bar: ProgressBar = %PlayerHealthBar
@onready var player_stamina_bar: ProgressBar = %PlayerStaminaBar
@onready var player_hunger_bar: HBoxContainer = %PlayerHungerBar

func _ready() -> void:
	player_health_bar.max_value = player.health_component.max_health
	player_stamina_bar.max_value = player.max_stamina
	player.stamina_updated.connect(update_stamina_bar)
	player.stamina_updated.connect(update_stamina_bar)
	player.health_component.health_changed.connect(update_health_bar)

func update_stamina_bar(new_stamina: int):
	player_stamina_bar.value = player.stamina

func update_hunger_bar(new_hunger: int):
	player_hunger_bar.value = new_hunger
	
func update_health_bar(old_health, new_health):
	player_health_bar.value = new_health
