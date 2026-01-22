extends Area3D
var score = 0

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.name == "Player": # or check by group, type, etc.
		score += 1
		print("Score:", score)
