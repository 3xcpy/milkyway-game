extends Node

@export var game: PackedScene = null

var game_instance: Game = null

@onready var main_menu: MainMenu = $MainMenu


func start_game() -> void:
	game_instance = game.instantiate()
	add_child(game_instance)
	main_menu.visible = false
	game_instance.connect("exit_to_main_menu", _on_game_exit_to_main_menu)
	game_instance.connect("game_over", _on_game_game_over)


func _on_main_menu_start_game() -> void:
	start_game()


func _on_game_exit_to_main_menu() -> void:
	game_instance.queue_free()
	main_menu.visible = true


func _on_game_game_over(_score: float) -> void:
	game_instance.queue_free()
	main_menu.visible = true