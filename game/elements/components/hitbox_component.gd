class_name HitboxComponent
extends Area2D

@export var health_component: HealthComponent;

func take_damage(attack: Attack):
	if health_component:
		health_component.take_damage(attack)
