class_name UI extends CanvasLayer

signal return_to_menu()

func _on_pause_menu_return_to_menu() -> void:
	return_to_menu.emit()