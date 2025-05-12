class_name MovingHealthBar
extends ProgressBar

@export var health_component: HealthComponent

@onready var timer: Timer = $Timer
@onready var damage_bar: ProgressBar = $DamageBar

var health: float = 0.0 : set = set_health

func _ready() -> void:
	if health_component:
		init_health(health_component.health)
		health_component.health_changed.connect(_fc_chomage)

func init_health(_health: float):
	health = _health
	max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health

func set_health(new_heath: float):
	var prev_health = health
	health = min(max_value, new_heath)
	value = health
	
	if health <= 0:
		queue_free()

	if health < prev_health:
		timer.start()
	else:
		damage_bar.value = health

func _fc_chomage(old, new):
	set_health(new)

func _on_timer_timeout() -> void:
	damage_bar.value = health
