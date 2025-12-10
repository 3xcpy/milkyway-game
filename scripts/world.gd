class_name World extends Node2D

signal game_over()


func _on_player_dead() -> void:
	game_over.emit()
