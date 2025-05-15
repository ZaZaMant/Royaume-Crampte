extends CharacterBody2D

@onready var player: Player
@onready var heath_component: HealthComponent = $HeathComponent

func _physics_process(delta):
	if player != null:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * 100.0
		move_and_slide()

func _on_heath_component_health_depleted() -> void:
	queue_free()
