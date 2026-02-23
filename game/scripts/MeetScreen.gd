extends Control

const MAIN_SCENE_PATH := "res://scenes/MainScreen.tscn"
const PULL_SCENE_PATH := "res://scenes/PullScreen.tscn"
const BUSTED_SCENE_PATH := "res://scenes/BustedScreen.tscn"

@onready var heat_label: Label = $VBoxContainer/HeatLabel
@onready var stats_label: Label = $VBoxContainer/StatsLabel

func _ready() -> void:
	_refresh_ui()

func _refresh_ui() -> void:
	heat_label.text = "Heat: %d / %d" % [GameState.heat, GameState.HEAT_BUST_THRESHOLD]
	var car: Dictionary = GameState.car_stats
	stats_label.text = "Car - Power:%d Grip:%d Reliability:%d Boost:%d" % [
		int(car.get("power", 0)),
		int(car.get("grip", 0)),
		int(car.get("reliability", 0)),
		int(car.get("boost", 0))
	]

func _on_take_pull_button_pressed() -> void:
	if GameState.is_busted():
		get_tree().change_scene_to_file(BUSTED_SCENE_PATH)
		return
	get_tree().change_scene_to_file(PULL_SCENE_PATH)

func _on_stay_button_pressed() -> void:
	GameState.add_heat(10)
	if GameState.is_busted():
		get_tree().change_scene_to_file(BUSTED_SCENE_PATH)
		return
	_refresh_ui()

func _on_leave_button_pressed() -> void:
	GameState.reset_for_new_night()
	get_tree().change_scene_to_file(MAIN_SCENE_PATH)
