extends Control

signal return_to_menu()

var paused: bool = false


func _ready() -> void:
	if Global.fullscreen:
		$FullscreenCheckBox.button_pressed = true


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		paused = !paused

	get_tree().paused = paused 
	visible = paused


func _on_fullscreen_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on and !Global.fullscreen:
		Global.saved_window_mode = DisplayServer.window_get_mode()
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Global.fullscreen = true
		print(Global.saved_window_mode)
	elif !toggled_on and Global.fullscreen:
		DisplayServer.window_set_mode(Global.saved_window_mode)
		Global.fullscreen = false


func _on_quit_button_button_up() -> void:
	get_tree().quit()


func _on_resume_button_button_up() -> void:
	paused = false


func _on_return_to_menu_button_button_up() -> void:
	get_tree().paused = false
	return_to_menu.emit()
