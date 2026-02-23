extends Control

const MEET_SCENE_PATH := "res://scenes/MeetScreen.tscn"

@onready var night_label: Label = $VBoxContainer/NightLabel
@onready var rep_label: Label = $VBoxContainer/RepLabel
@onready var cash_label: Label = $VBoxContainer/CashLabel

var save_system: SaveSystem = SaveSystem.new()

func _ready() -> void:
	_refresh_ui()

func _refresh_ui() -> void:
	night_label.text = "Night: %d" % GameState.night
	rep_label.text = "Rep: %d" % GameState.rep
	cash_label.text = "Cash: $%d" % GameState.cash

func _on_go_to_meet_button_pressed() -> void:
	get_tree().change_scene_to_file(MEET_SCENE_PATH)

func _on_save_button_pressed() -> void:
	save_system.save(GameState.to_dict())

func _on_load_button_pressed() -> void:
	var loaded: Variant = save_system.load()
	if loaded != null:
		GameState.load_from_dict(loaded as Dictionary)
		_refresh_ui()
