extends CharacterBody2D

@export var health: float = 5.0

func damage(dmg: float) -> void:
	health -= dmg
	if health <= 0.0:
		queue_free()