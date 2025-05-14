class_name Attack

var attack_damage: float = 10.0;
var knockback_force: float = 100.0;
var attack_position: Vector2

func _init(damage: int) -> void:
	attack_damage = damage
