extends Area3D

var GameManager = "$../../../../.."
var add_score

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("ball"):
		GameManager.add_score(1)
