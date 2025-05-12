extends Node2D

@export var animation_tree: AnimationTree
@onready var player: CharacterBody2D = get_owner()

var last_facing_direction := Vector2(0, 1)

func  _physics_process(delta: float) -> void:

	if !player.idle:
		last_facing_direction = player.velocity.normalized()

	# animations
	animation_tree.set("parameters/Idle/blend_position", last_facing_direction)
	animation_tree.set("parameters/Run/blend_position", last_facing_direction)
