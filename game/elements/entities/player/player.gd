class_name Player
extends CharacterBody2D

@export var inventory_data: InventoryData

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

signal toggle_inventory

var current_speed = 0.0
var last_facing_direction: Vector2 = Vector2(0, -1)

# Hunger
var hunger: int
var last_time_ate: int

# Thirst
var thirst: int

# StaminaItem
var stamina: float

#var inventory: Inventory = Inventory.new()
@export var hand_equiped: Item :
	set(e):
		hand_equiped = e
		print("[Player] Equiped ", hand_equiped.name)

var idle: bool
var can_pickup: bool

func _ready() -> void:
	health_component.take_damage(Attack.new(30))
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
		stamina -= 0.2
	elif stamina < max_stamina:
		stamina += 0.2

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

func heal(heal_value: int):
	health_component.add_health(heal_value)

func get_drop_position() -> Vector2:
	return camera.global_position + (last_facing_direction * 24)
