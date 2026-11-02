extends Node
## Autoload that keeps the score. UI listens to `score_changed`
## instead of the manager reaching into scenes.

signal score_changed(new_score: int)

var score: int = 0


func add_score(amount: int = 1) -> void:
	score += amount
	score_changed.emit(score)


func reset_score() -> void:
	score = 0
	score_changed.emit(score)
