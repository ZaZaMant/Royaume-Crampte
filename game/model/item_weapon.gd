class_name ItemWeapon
extends Item

@export var attack_damage: int
@export var knockback_force: int
@export var attack_animations: AnimationLibrary

func attack(target):
	target.take_damage(Attack.new(attack_damage, knockback_force))
