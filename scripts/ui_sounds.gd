extends Node

var hover_sound := preload("res://sounds/menuhover.wav")
var click_sound := preload("res://sounds/click.wav")


var playback:AudioStreamPlaybackPolyphonic


func _ready() -> void:
	connect_buttons(get_tree().root)
	get_tree().connect("node_added", _on_node_added)


func _enter_tree() -> void:
	# Create an audio player
	var player = AudioStreamPlayer.new()
	add_child(player)

	# Create a polyphonic stream so we can play sounds directly from it
	var stream = AudioStreamPolyphonic.new()
	stream.polyphony = 32
	player.stream = stream
	player.play()
	# Get the polyphonic playback stream to play sounds
	playback = player.get_stream_playback()

	get_tree().node_added.connect(_on_node_added)


func _on_node_added(node:Node) -> void:
	if node is Button:
		connect_to_button(node)


func connect_to_button(node: Node):
	node.mouse_entered.connect(_play_hover)
	node.pressed.connect(_play_pressed)


func _play_hover() -> void:
	playback.play_stream(hover_sound, 0, 0, randf_range(0.9, 1.1))


func _play_pressed() -> void:
	playback.play_stream(click_sound)


func connect_buttons(root):
	for child in root.get_children():
		if child is BaseButton:
			connect_to_button(child)
		connect_buttons(child)