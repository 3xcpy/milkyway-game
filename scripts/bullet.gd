extends Area2D

@export var speed: float = 1000.0
@export var lifetime: float = 10.0
@export var damage: float = 1.0

func _physics_process(delta: float) -> void:
	global_position += Vector2(1.0, 0.0).rotated(global_rotation) * speed * delta
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()
	

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("damage"):
		body.damage(damage)
	queue_free()