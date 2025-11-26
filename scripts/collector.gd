extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		assert(body.has_method("consume"), "Enemies need to be consumable")
		body.consume()
		#TODO: give the player ammo
