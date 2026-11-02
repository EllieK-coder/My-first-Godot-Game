extends Control

const MENU_SCENE := "res://scenes/menu.tscn"


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(MENU_SCENE)
