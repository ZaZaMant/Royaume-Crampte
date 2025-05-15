class_name Weapon
extends StaticBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var attack_timer: Timer = $AttackTimer
@onready var hit_cast: ShapeCast2D = $HitCast

var attacking: bool = false
var item_weapon: ItemWeapon

func _physics_process(delta: float) -> void:
	if attacking:
		rotation = lerp(rotation, 20.0, delta)
	else:
		rotation = lerp(rotation, 0.0, delta)

func attack():
	if item_weapon:
		attack_timer.start()
		attacking = true
		
		hit_cast.force_shapecast_update()
		
		print("Attack", hit_cast.is_colliding())
		
		if hit_cast.is_colliding():
			print("Attacking another entity")
			var collide_with = hit_cast.get_collider(0)
			if collide_with != get_parent().find_child('HitboxComponent'):
				item_weapon.attack(collide_with)

func set_weapon(item: ItemWeapon):
	if item:
		item_weapon = item
		sprite.texture = item.texture
	else:
		item_weapon = null
		sprite.texture = null

func _on_attack_timer_timeout() -> void:
	attacking = false
