class_name Attack

var attack_damage: float = 10.0;
var knockback_force: float = 100.0;
var attack_position: Vector2

func _init(damage: float = 10.0, _knockback_force: float = 100.0) -> void:
	attack_damage = damage
	knockback_force = _knockback_force
