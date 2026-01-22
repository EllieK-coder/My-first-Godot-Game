extends Node

var score: int = 0
@onready var score_label: Label = get_node("../UI/ScoreLabel") # Adjust path if different

func add_score(amount: int = 1) -> void:
	score += amount
	update_ui()

func update_ui() -> void:
	score_label.text = "Score: %d" % score
