class_name HUD extends Control

@onready var ammo_label: Label = $MarginContainer/AmmoLabel

func _ready() -> void:
	Global.hud = self


func _process(_delta: float) -> void:
	set_ammo(Global.ammo)


func set_ammo(val: int) -> void:
	ammo_label.text = str(val)