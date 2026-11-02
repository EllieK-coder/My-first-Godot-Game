extends Control
## Pause overlay. Runs while the tree is paused (process_mode = Always).

const MENU_SCENE := "res://scenes/menu.tscn"


func _ready() -> void:
	hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		set_paused(not get_tree().paused)
		get_viewport().set_input_as_handled()


func set_paused(paused: bool) -> void:
	get_tree().paused = paused
	visible = paused
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if paused else Input.MOUSE_MODE_CAPTURED


func _on_resume_pressed() -> void:
	set_paused(false)


func _on_restart_pressed() -> void:
	get_tree().paused = false
	GameManager.reset_score()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(MENU_SCENE)
