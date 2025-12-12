class_name MainMenu extends Control

signal start_game()

@onready var score_label: Label = $ScoreLabel


func _process(_delta) -> void:
	if Global.fullscreen:
		$FullscreenCheckBox.button_pressed = true


func update_score_label(score: float) -> void:
	if score == 0:
		score_label.text = ""
	else:
		score_label.text = "Best Score: " + str(snapped(score, 0.01))


func _on_play_button_button_up() -> void:
	start_game.emit()


func _on_quit_button_button_up() -> void:
	get_tree().quit()


func _on_fullscreen_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.fullscreen:
		Global.saved_window_mode = DisplayServer.window_get_mode()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Global.fullscreen = true
		print(Global.saved_window_mode)
	elif !toggled_on and Global.fullscreen:
		DisplayServer.window_set_mode(Global.saved_window_mode)
		Global.fullscreen = false