extends Node2D

@export var enemy_scene: PackedScene = null
@export var spawn_delay: float = 2.0

var timer: float = 0.0


func _physics_process(delta: float) -> void:
	timer += delta
	if timer >= spawn_delay:
		spawn()
		timer = 0.0


func spawn() -> void:
	var enemy: Node2D = enemy_scene.instantiate()
	add_child(enemy)
	enemy.global_position = global_position