class_name HealthIndicator extends Control

var value: int = 5

@onready var box := $MarginContainer/VBoxContainer

func update():
	for i in box.get_child_count():
		box.get_child(i).visible = value > i