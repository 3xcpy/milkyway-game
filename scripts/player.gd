extends CharacterBody2D

signal dead()

@export var speed: float = 100.0
@export var accel: float = 50.0
@export var decel: float = 10.0

@export var max_health: int = 5
@export var time_to_heal: float = 7.0

var health: int = max_health
var heal_timer: float = 0.0
var heal: bool = false


func _process(_delta: float) -> void:
	Global.health = health


func _physics_process(delta: float) -> void:
	if heal:
		heal_timer += delta
		if heal_timer >= time_to_heal:
			health += 1
			heal_timer = 0.0
			if health >= max_health:
				health = max_health
				heal = false
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


func damage(dmg: int) -> void:
	print("Damaged!!!")
	health -= dmg
	heal = true
	if health <= 0:
		dead.emit()