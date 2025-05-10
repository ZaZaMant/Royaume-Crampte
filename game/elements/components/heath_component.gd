class_name HealthComponent
extends Node2D

@export var max_health: float = 100.0
@export var whant_health_bar: bool = true

signal health_depleted
signal health_changed(old_value, new_value)

var health: float

func _ready() -> void:
	health = max_health

func take_damage(attack: Attack):
	var old_health = health
	health -= attack.attack_damage
	health_changed.emit(old_health, health)
	
	if health <= 0:
		health_depleted.emit()
