extends Node

@export var game: PackedScene = null

var config := ConfigFile.new()
var game_instance: Game = null

@onready var main_menu: MainMenu = $MainMenu
@onready var death_sound: AudioStreamPlayer = $Death


func _ready() -> void:
	var err = config.load("user://score.cfg")
	if err != OK:
		main_menu.update_score_label(0.0)
		config.set_value("score", "score", 0.0)
		config.save("user://score.cfg")
	else:
		main_menu.update_score_label(config.get_value("score", "score"))


func start_game() -> void:
	game_instance = game.instantiate()
	add_child(game_instance)
	main_menu.visible = false
	main_menu.set_process(false)
	game_instance.connect("exit_to_main_menu", _on_game_exit_to_main_menu)
	game_instance.connect("game_over", _on_game_game_over)


func _on_main_menu_start_game() -> void:
	start_game()


func _on_game_exit_to_main_menu() -> void:
	game_instance.queue_free()
	main_menu.visible = true
	main_menu.set_process(true)


func _on_game_game_over(score: float) -> void:
	game_instance.queue_free()
	main_menu.visible = true
	main_menu.set_process(true)
	if config.get_value("score", "score") < score:
		config.set_value("score", "score", score)
		config.save("user://score.cfg")
		main_menu.update_score_label(score)

	death_sound.play()