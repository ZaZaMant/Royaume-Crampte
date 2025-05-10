extends CharacterBody2D

@export var movement_speed = 300.0

@onready var _camera: Camera2D = %Camera2D

var inventory: Inventory = Inventory.new()

func _physics_process(delta: float) -> void:
	var direction = get_input()
	
	velocity = Vector2(direction.x, direction.y) * movement_speed
	
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
