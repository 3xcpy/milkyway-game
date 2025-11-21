extends CharacterBody2D

@export var speed: float = 100.0
@export var accel: float = 50.0
@export var decel: float = 10.0


func _physics_process(delta: float) -> void:
	move(delta)


func move(delta: float) -> void:
	var dir: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var wish_vel := dir * speed

	var new_vel := Vector2.ZERO

	# accelerate
	if wish_vel.length() > velocity.length():
		new_vel = lerp(velocity, wish_vel, accel * delta)
	else:
		new_vel = lerp(velocity, Vector2.ZERO, decel * delta)
	
	velocity = new_vel
	move_and_slide()