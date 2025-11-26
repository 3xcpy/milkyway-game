extends Area2D

var ammo_per_enemy: int = 20


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		assert(body.has_method("consume"), "Enemies need to be consumable")
		body.consume()
		Global.ammo += ammo_per_enemy
