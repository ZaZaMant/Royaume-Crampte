class_name Weapon
extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var hit_area: Area2D = $HitArea
@onready var attack_timer: Timer = $AttackTimer

var attacking: bool = false

func _physics_process(delta: float) -> void:
	if attacking:
		rotation = lerp(rotation, 20.0, delta)
	else:
		rotation = lerp(rotation, 0.0, delta)

func attack():
	attack_timer.start(2.0)
	attacking = true

func set_weapon(item: ItemWeapon):
	if item:
		sprite.texture = item.texture
	else:
		sprite.texture = null

func _on_attack_timer_timeout() -> void:
	attacking = false
