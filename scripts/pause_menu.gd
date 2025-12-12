extends Control

signal return_to_menu()

var paused: bool = false
var saved_window_mode = null


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		paused = !paused

	get_tree().paused = paused 
	visible = paused


func _on_fullscreen_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		saved_window_mode = DisplayServer.window_get_mode()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(saved_window_mode)


func _on_quit_button_button_up() -> void:
	get_tree().quit()


func _on_resume_button_button_up() -> void:
	paused = false


func _on_return_to_menu_button_button_up() -> void:
	get_tree().paused = false
	return_to_menu.emit()
