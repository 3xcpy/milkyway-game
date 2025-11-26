extends CharacterBody2D

@export var decel: float = 1.0

@export var health: float = 5.0
@export var throw_force: float = 1000.0

var grabbed: bool = false

@onready var collider: CollisionShape2D = $CollisionShape2D


func _physics_process(delta: float) -> void:
	if !grabbed:
		velocity = lerp(velocity, Vector2.ZERO, decel * delta)
		move_and_slide()


func damage(dmg: float) -> void:
	health -= dmg
	if health <= 0.0:
		queue_free()


func grab() -> void:
	collider.disabled = true
	grabbed = true


func ungrab(dir: Vector2) -> void:
	collider.disabled = false
	velocity = dir * throw_force
	grabbed = false


func consume() -> void:
	# TODO: add death and animation perchance?
	print("Consumed")
	pass