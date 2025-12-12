extends CharacterBody2D

signal dead()

@export var speed: float = 100.0
@export var accel: float = 50.0
@export var decel: float = 10.0

@export var max_health: int = 3
@export var time_to_heal: float = 10.0

var health: int = max_health
var heal_timer: float = 0.0
var heal: bool = false

@onready var iframe_timer: Timer = $IFrameTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var hurt_sound: AudioStreamPlayer = $Hurt


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
	if iframe_timer.is_stopped():
		iframe_timer.start()
		animation_player.play("flicker")

		health -= dmg
		heal = true
		if health <= 0:
			dead.emit()
		else:
			hurt_sound.play()	


func _on_i_frame_timer_timeout() -> void:
	animation_player.play("RESET")