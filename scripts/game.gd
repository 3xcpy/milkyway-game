class_name Game extends Node

signal game_over(score: float)
signal exit_to_main_menu()

var start_time: float = 0.0

func _ready() -> void:
	start_time = Time.get_unix_time_from_system()

func _process(_delta: float) -> void:
	var current_time: float = Time.get_unix_time_from_system()
	Global.time = current_time - start_time

func _on_ui_return_to_menu() -> void:
	exit_to_main_menu.emit()

func _on_world_game_over() -> void:
	game_over.emit(Global.time)