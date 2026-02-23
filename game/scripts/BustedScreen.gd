extends Control

const MAIN_SCENE_PATH := "res://scenes/MainScreen.tscn"

func _on_back_to_main_button_pressed() -> void:
	GameState.reset_for_new_night()
	get_tree().change_scene_to_file(MAIN_SCENE_PATH)
