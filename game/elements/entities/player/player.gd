extends CharacterBody2D

@export var movement_speed = 300.0

@export_category("Player Stats")
@export_range(5, 20, 1) var max_hunger = 5
@export var max_stamina = 100
@export var max_thirst = 100

@onready var _camera: Camera2D = %Camera2D
@onready var _moving_health_bar: MovingHealthBar = $MovingHealthBar # remove

# Hunger
var hunger: int
var last_time_ate: int

# Thirst
var thirst: int

# Stamina
var stamina: float

var inventory: Inventory = Inventory.new()

func _ready() -> void:
	hunger = max_hunger
	thirst = max_thirst
	stamina = max_stamina
	_moving_health_bar.health = 100 # remove

func _physics_process(delta: float) -> void:
	var direction = get_input()

	velocity = Vector2(direction.x, direction.y) * movement_speed
	
	if !velocity.is_zero_approx():
		stamina -= 0.1
	elif stamina < max_stamina:
		stamina += 0.2

	move_and_slide()

func on_item_picked_up(item: Item):
	print("[Player] picked up : ", item.name)
	inventory.add_item(item)

func get_input() -> Vector2:
	var input_dir: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("left"):
		input_dir.x = -1
	if Input.is_action_pressed("right"):
		input_dir.x = 1
	if Input.is_action_pressed("up"):
		input_dir.y = -1
	if Input.is_action_pressed("down"):
		input_dir.y = 1
	return input_dir

# remove
func _on_heath_component_health_changed(old_value: Variant, new_value: Variant) -> void:
	_moving_health_bar.health = new_value
