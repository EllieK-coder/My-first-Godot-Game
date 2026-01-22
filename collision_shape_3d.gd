extends CollisionShape3D
c

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if body.is_in_group("floor"):
		linear_velocity.y = -linear_velocity.y * 0.8 # Bounce factor (0.8 for 80% energy loss)
	
	if interactRay.is_colliding(): 
		rotation = rotation.reflect(interactRay.get_collision_normal())
