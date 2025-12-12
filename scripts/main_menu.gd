class_name MainMenu extends Control

signal start_game()

@onready var score_label: Label = $ScoreLabel


func update_score_label(score: float) -> void:
	if score == 0:
		score_label.text = ""
	else:
		score_label.text = "Best Score: " + str(snapped(score, 0.01))


func _on_play_button_button_down() -> void:
	start_game.emit()

func _on_quit_button_button_down() -> void:
	get_tree().quit()