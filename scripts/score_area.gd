extends Area3D
## Sits just under a hoop's rim. Counts a basket when a ball
## passes through it moving downward.

@export var points: int = 1
@export var cooldown_seconds: float = 1.0

var _last_score_time: float = -INF


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if not body.is_in_group("ball"):
		return
	if body is RigidBody3D and body.linear_velocity.y > 0.0:
		return # ball came up through the net, not a basket
	var now := Time.get_ticks_msec() / 1000.0
	if now - _last_score_time < cooldown_seconds:
		return
	_last_score_time = now
	GameManager.add_score(points)
