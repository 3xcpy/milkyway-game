extends Node2D

@export var enemy_scene: PackedScene = null
@export var initial_min_spawn_delay: float = 2.0
@export var initial_max_spawn_delay: float = 10.0

var min_spawn_delay: float = initial_min_spawn_delay
var max_spawn_delay: float = initial_max_spawn_delay

var spawn_delay: float = 0.0
var timer: float = 0.0


func _ready() -> void:
	compute_spawn_delay()


func _physics_process(delta: float) -> void:
	timer += delta
	if timer >= spawn_delay:
		spawn()
		timer = 0.0
		compute_spawn_delay()


func spawn() -> void:
	var enemy: Node2D = enemy_scene.instantiate()
	add_child(enemy)
	enemy.global_position = global_position


func compute_spawn_delay() -> void:
	compute_bounds()
	spawn_delay = randf_range(min_spawn_delay, max_spawn_delay)


func compute_bounds() -> void:
	min_spawn_delay = initial_min_spawn_delay * pow(0.95, int(Global.time))
	max_spawn_delay = initial_max_spawn_delay * pow(0.95, int(Global.time))
	if min_spawn_delay < 1.0:
		min_spawn_delay = 1.0
	if max_spawn_delay < 1.0:
		max_spawn_delay = 1.0