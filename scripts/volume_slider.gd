extends HSlider
## Controls the volume of one audio bus (linear 0..1 slider).

@export var bus_name: String = "Music"

var _bus_index: int


func _ready() -> void:
	_bus_index = AudioServer.get_bus_index(bus_name)
	if _bus_index == -1:
		push_warning("Audio bus '%s' not found" % bus_name)
		return
	value = db_to_linear(AudioServer.get_bus_volume_db(_bus_index))
	value_changed.connect(_on_value_changed)


func _on_value_changed(new_value: float) -> void:
	AudioServer.set_bus_volume_db(_bus_index, linear_to_db(new_value))
