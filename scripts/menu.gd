extends Control

const COURT_SCENE := "res://scenes/court.tscn"
const OPTIONS_SCENE := "res://scenes/options_menu.tscn"


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_play_pressed() -> void:
	GameManager.reset_score()
	get_tree().change_scene_to_file(COURT_SCENE)


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file(OPTIONS_SCENE)


func _on_quit_pressed() -> void:
	get_tree().quit()
