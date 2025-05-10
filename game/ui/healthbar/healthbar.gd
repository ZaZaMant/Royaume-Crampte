extends ProgressBar

@onready var timer: Timer = $Timer
@onready var damage_bar: ProgressBar = $DamageBar

var health: float = 0.0 : set = _set_health

func init_health(_health: float):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health

func _set_health(new_heath: float):
	var prev_health = health
	health = min(max_value, new_heath)
	value = health
	
	if health <= 0:
		queue_free()

	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health

func _on_timer_timeout() -> void:
	pass # Replace with function body.
