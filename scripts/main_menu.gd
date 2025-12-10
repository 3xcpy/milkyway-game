class_name MainMenu extends Control

signal start_game()

func _on_play_button_button_down() -> void:
	start_game.emit()