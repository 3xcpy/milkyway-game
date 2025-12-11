class_name Attack extends Area2D

@export var damage: int = 1
@export var speed: float = 1.0
@export var linger: float = 0.5
@export var cooldown: float = 3.0


var active: bool = false
var timer: float = 0.0
var linger_timer: float = 0.0
var cooldown_timer: float = 0.0
var detect_collisions: bool = false


func attack() -> void:
	active = true


func _physics_process(delta: float) -> void:
	if active:
		tick(delta)
	else:
		visible = false
		detect_collisions = false


func tick(delta: float) -> void:
	detect_collisions = true
	visible = true
	if timer < speed:
		timer += delta
		var new_scale = clampf(timer / speed, 0.0, 1.0)
		global_scale = Vector2(new_scale, new_scale)
	elif linger_timer < linger:
		linger_timer += delta
	elif cooldown_timer < cooldown:
		cooldown_timer += delta
		detect_collisions = false
		visible = false
	else:
		timer = 0.0
		linger_timer = 0.0
		cooldown_timer = 0.0
		active = false


func _on_body_entered(body: Node2D) -> void:
	if detect_collisions:
		if body.is_in_group("Player"):
			assert(body.has_method("damage"), "Player must be damageable")
			body.damage(damage)