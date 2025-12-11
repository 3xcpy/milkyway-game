class_name HealthIndicator extends Control

@onready var box := $MarginContainer/VBoxContainer

func _process(_delta: float) -> void:
	for i in box.get_child_count():
		box.get_child(i).visible = Global.health > i