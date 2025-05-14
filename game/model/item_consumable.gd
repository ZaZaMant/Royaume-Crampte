class_name ItemConsumable
extends Item

@export var heal_value: int = 0
@export var stamina_value: float = 0.0
@export var hunger_value: int = 0

func use(target) -> void:
	if heal_value != 0:
		target.heal(heal_value)
	if stamina_value != 0:
		target.add_stamina(stamina_value)
	if hunger_value != 0:
		target.add_hunger(hunger_value)
