class_name HUD extends Control

@onready var ammo_label: Label = $MarginContainer/AmmoLabel
@onready var score_label: Label = $MarginContainer2/ScoreLabel

func _ready() -> void:
	Global.hud = self


func _process(_delta: float) -> void:
	set_ammo(Global.ammo)
	set_score(Global.time)


func set_ammo(val: int) -> void:
	ammo_label.text = str(val)

func set_score(val: float) -> void:
	score_label.text = str(snapped(val, 0.01))