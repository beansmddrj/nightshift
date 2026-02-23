extends Control

const MEET_SCENE_PATH := "res://scenes/MeetScreen.tscn"
const BUSTED_SCENE_PATH := "res://scenes/BustedScreen.tscn"

@onready var meter_label: Label = $VBoxContainer/MeterLabel
@onready var instructions_label: Label = $VBoxContainer/InstructionsLabel
@onready var result_label: Label = $VBoxContainer/ResultLabel
@onready var stop_button: Button = $VBoxContainer/StopButton
@onready var continue_button: Button = $VBoxContainer/ContinueButton

var meter_position: float = 0.0
var meter_velocity: float = 80.0
var running: bool = true
var success_window: float = 20.0

func _ready() -> void:
	result_label.text = ""
	continue_button.visible = false
	success_window = _compute_success_window()
	instructions_label.text = "Press Stop near 50. Window size: %.1f" % success_window
	_update_meter_label()

func _process(delta: float) -> void:
	if not running:
		return

	meter_position += meter_velocity * delta
	if meter_position >= 100.0:
		meter_position = 100.0
		meter_velocity = -abs(meter_velocity)
	elif meter_position <= 0.0:
		meter_position = 0.0
		meter_velocity = abs(meter_velocity)

	_update_meter_label()

func _compute_success_window() -> float:
	var car: Dictionary = GameState.car_stats
	var grip: int = int(car.get("grip", 0))
	var reliability: int = int(car.get("reliability", 0))
	var boost: int = int(car.get("boost", 0))

	var window := 14.0 + (grip * 1.2) + (reliability * 0.8) - (boost * 0.3)
	return clamp(window, 8.0, 30.0)

func _update_meter_label() -> void:
	meter_label.text = "Timing: %.1f" % meter_position

func _resolve_pull() -> void:
	var distance := abs(meter_position - 50.0)
	var success := distance <= (success_window * 0.5)

	if success:
		var power: int = int(GameState.car_stats.get("power", 0))
		GameState.add_rep(5)
		GameState.add_cash(25 + (power * 2))
		GameState.add_heat(15)
		result_label.text = "Win! +5 Rep, +$%d" % (25 + (power * 2))
	else:
		GameState.add_rep(-3)
		GameState.add_heat(10)
		result_label.text = "Lose! -3 Rep"

func _on_stop_button_pressed() -> void:
	if not running:
		return

	running = false
	stop_button.disabled = true
	_resolve_pull()
	continue_button.visible = true

func _on_continue_button_pressed() -> void:
	if GameState.is_busted():
		get_tree().change_scene_to_file(BUSTED_SCENE_PATH)
		return

	get_tree().change_scene_to_file(MEET_SCENE_PATH)