extends CharacterBody2D

var SPEED = 1

const SURROUND = 1
const AIM = 2
const ATTACK = 3

@onready var player: Player
@onready var heath_component: HealthComponent = $HeathComponent

var state = SURROUND

var aiming
var target
var randomnum

func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()

func _physics_process(delta):
	match state:
		SURROUND:
			move(get_circle_position(randomnum), delta)
			
		ATTACK:
			move(player.global_position,delta)
		AIM:
			aiming = player.global_position
			move(aiming,delta)
	

func _on_heath_component_health_depleted() -> void:
	queue_free()
	
func move(target,delta):
	if player != null:
		var direction = (target - global_position).normalized()
		velocity = direction * 100.0
		var desired_velocity = direction * SPEED
		var steering = (desired_velocity - velocity) * delta * 2.5
		velocity += steering
		move_and_slide()
	
func get_circle_position(random) :
	if player != null:
		var kill_circle_centre = player.global_position
		var radius = 40
		var angle = random * PI * 2
		var x = kill_circle_centre.x + cos(angle) * radius
		var y = kill_circle_centre.y + cos(angle) * radius
		return Vector2(x,y)

func _on_Attract_body_entered(body):
	if body.is_in_group("Enemy"):
		body.attack_timer.start()
		
func _on_Attract_body_exited(body):
		if body.is_in_group("Enemy"):
			body.attack_timer.stop()
			body.state = body.SURROUND
		
func _on_Attack_body_entered(body):
	if body.is_in_group("Enemy"):
		body.state = body.AIM
