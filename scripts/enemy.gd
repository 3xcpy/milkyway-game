extends CharacterBody2D

@export var speed: float = 200.0
@export var accel: float = 50.0
@export var decel: float = 10.0
@export var stun_decel: float = 1.0

@export var health: float = 5.0
@export var throw_force: float = 1000.0

@export var stopping_distance: float = 96.0

var grabbed: bool = false
var stunned: bool = false

@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var attack: Attack = $Attack

@onready var nav_timer: Timer = $NavTimer
@onready var stun_timer: Timer = $StunTimer

@onready var sprite: Sprite2D = $Sprite2D


func _physics_process(delta: float) -> void:
	if !grabbed and stunned:
		velocity = lerp(velocity, Vector2.ZERO, stun_decel * delta)
	elif !grabbed:
		walk(delta)

	move_and_slide()


func walk(delta: float) -> void:
	if nav_agent.distance_to_target() <= stopping_distance or attack.active:
		velocity = lerp(velocity, Vector2.ZERO, decel * delta)
		attack.attack()
		return

	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	var desired_vel = dir * speed
	var new_vel = Vector2.ZERO

	if velocity.length() < desired_vel.length():
		new_vel = lerp(velocity, desired_vel, accel * delta)
	else:
		new_vel = lerp(velocity, Vector2.ZERO, decel * delta)
	
	if nav_agent.avoidance_enabled:
		nav_agent.set_velocity(new_vel)
	else:
		velocity = new_vel


func damage(dmg: float) -> void:
	health -= dmg
	if health <= 0.0:
		queue_free()


func grab() -> void:
	collider.disabled = true
	grabbed = true
	stun_timer.stop()
	attack.active = false

	sprite.modulate.a = 0.3


func ungrab(dir: Vector2) -> void:
	collider.disabled = false
	velocity = dir * throw_force
	grabbed = false
	stun_timer.start()
	stunned = true
	sprite.modulate.a = 1.0


func consume() -> bool:
	if stunned:
		die()
		return true
	return false


func die() -> void:
	queue_free()


func _on_stun_timer_timeout() -> void:
	stunned = false

func _on_nav_timer_timeout() -> void:
	var target = get_tree().get_first_node_in_group("Player")
	nav_agent.target_position = target.global_position

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	velocity = safe_velocity