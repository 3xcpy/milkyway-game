extends Node2D

var held: Node2D = null

@onready var ray: RayCast2D = $RayCast2D


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("grab"):
		if ray.is_colliding():
			var col: Node = ray.get_collider()
			if col.is_in_group("Enemies"):
				assert(col.has_method("grab"), "Enemies need to be grabbable")
				col.grab()
				held = col

	if held != null:
		held.global_position = global_position
