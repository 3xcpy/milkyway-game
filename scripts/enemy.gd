extends CharacterBody2D

@export var health: float = 5.0

@onready var collider: CollisionShape2D = $CollisionShape2D


func damage(dmg: float) -> void:
	health -= dmg
	if health <= 0.0:
		queue_free()


func grab() -> void:
	collider.disabled = true


func ungrab() -> void:
	collider.disabled = false