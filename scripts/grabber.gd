extends Node2D

var held: Node2D = null

@onready var ray: RayCast2D = $RayCast2D
@onready var grab_point: Node2D = $GrabPoint


func _physics_process(_delta: float) -> void:
	var dir: Vector2 = (get_global_mouse_position() - global_position).normalized()
	global_rotation = dir.angle()

	if Input.is_action_just_pressed("grab"):
		if held == null:
			if ray.is_colliding():
				var col: Node = ray.get_collider()
				if col.is_in_group("Enemies"):
					assert(col.has_method("grab"), "Enemies need to be grabbable")
					col.grab()
					held = col
		else:
			assert(held.has_method("ungrab"), "Enemies need to be ungrabbable")
			held.ungrab(dir)
			held = null

	if held != null:
		held.global_position = grab_point.global_position
