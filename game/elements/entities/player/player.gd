class_name Player
extends CharacterBody2D

@export_category("Player inventory")
@export var inventory_data: InventoryData
@export var weapon_inventory_data: InventoryDataWeapon

@export_category("Player movement stats")
@export var walk_speed = 180.0
@export var run_speed = 280.0
@export var acceleration = 80.0

@export_category("Player Stats")
@export_range(5, 20, 1) var max_hunger = 5
@export var max_health = 100
@export var max_stamina = 100
@export var max_thirst = 100

@onready var _camera: Camera2D = %Camera2D
@onready var _animation_tree: AnimationTree = $AnimationTree
@onready var interaction_cast: ShapeCast2D = $InteractionShapeCast
@onready var camera: Camera2D = %Camera2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var weapon: Weapon = %Weapon

signal toggle_inventory
signal stamina_updated(new_stamina)
signal hunger_updated(new_hunger)

var current_speed = 0.0
var last_facing_direction: Vector2 = Vector2(0, -1)

# Hunger
var hunger: int
var last_time_ate: int

# Thirst
var thirst: int

# StaminaItem
var stamina: float

@export var hand_equiped: Item :
	set(e):
		hand_equiped = e
		print("[Player] Equiped ", hand_equiped.name)

var idle: bool
var can_pickup: bool

func _ready() -> void:
	weapon_inventory_data.inventory_updated.connect(set_weapon)
	health_component.take_damage(Attack.new())
	PlayerManager.player = self
	hunger = max_hunger
	thirst = max_thirst
	stamina = max_stamina

func _physics_process(delta: float) -> void:
	var direction = get_input()
	
	var is_running = Input.is_action_pressed("running")
	var target_speed = run_speed if is_running else walk_speed

	current_speed = lerp(current_speed, target_speed, acceleration * delta)
	velocity = direction * current_speed
	
	idle = !velocity
	
	if !idle:
		last_facing_direction = direction
	
	if is_running:
		stamina -= 0.18
	elif stamina < max_stamina:
		stamina += 0.15 + cos(Time.get_ticks_msec()) * 0.4
	
	stamina_updated.emit(stamina)

	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()
	if Input.is_action_just_pressed("interact"):
		interact()

func on_item_picked_up(item: Item):
	print("[Player] picked up : ", item.name)
	#inventory.add_item(item)

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
	return input_dir.normalized()

func interact():
	if interaction_cast.is_colliding():
		print("Interact")
		interaction_cast.get_collider(0).player_interact(self)

func get_drop_position() -> Vector2:
	return camera.global_position + (last_facing_direction * 24)

func heal(heal_value: int):
	health_component.add_health(heal_value)

func add_stamina(add: float):
	stamina += add
	stamina_updated.emit(stamina)

func add_hunger(add: int):
	hunger += add
	hunger_updated.emit(hunger)
	
func set_weapon(inventory_data: InventoryData):
	if inventory_data.slot_datas.get(0):
		var weapon_item = inventory_data.slot_datas[0].item_data
		weapon.set_weapon(weapon_item)
	else:
		weapon.set_weapon(null)
