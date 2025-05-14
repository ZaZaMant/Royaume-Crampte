extends CharacterBody2D

@onready var player: Player

func _physics_process(delta):
	if player != null:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 100.0
		move_and_slide()
	
