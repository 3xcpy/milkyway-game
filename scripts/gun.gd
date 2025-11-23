extends Node2D

@export var bullet: PackedScene = null
@export var ammo: int = 100	# initial value
@export var fire_rate: float = 20.0

var timer: float = 0.0

var burst_fire_rate: float = 2.0
var burst_spread: float = 20.0	# in degrees
var burst_fire_amount: int = 10

var stream_fire_rate: float = 20.0


func _process(delta: float) -> void:
	timer += delta
	if Input.is_action_pressed("shoot_1") and timer > (1.0/burst_fire_rate) and ammo >= burst_fire_amount:
		shoot_burst()
		timer = 0.0
	
	if Input.is_action_pressed("shoot_2") and timer > (1.0/stream_fire_rate) and ammo > 0:
		shoot_stream()
		timer = 0.0

	Global.hud.set_ammo(ammo)


func shoot_burst() -> void:
	ammo -= burst_fire_amount

	var shoot_dir: Vector2 = (get_global_mouse_position() - global_position).normalized()

	for n in (burst_fire_amount - 1):
		var bullet_instance: Area2D = bullet.instantiate()
		bullet_instance.global_position = global_position
		bullet_instance.global_rotation = shoot_dir.angle() + deg_to_rad((randf() * 2 - 1.0) * burst_spread)
		add_child(bullet_instance)


func shoot_stream() -> void:
	ammo -= 1
	var shoot_dir: Vector2 = (get_global_mouse_position() - global_position).normalized()
	var bullet_instance: Area2D = bullet.instantiate()
	bullet_instance.global_position = global_position
	bullet_instance.global_rotation = shoot_dir.angle()
	add_child(bullet_instance)
