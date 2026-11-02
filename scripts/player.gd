extends CharacterBody3D
## First-person player that can pick up, carry and throw the ball.
## Based on the "Godot4.3 Simple FPS Controller" by CiaNCI Studio (MIT).

@export_group("Movement")
@export var move_speed := 5.0
@export var acceleration := 7.5
@export var jump_force := 4.5
@export var gravity := 9.8

@export_group("Camera")
@export var mouse_sensitivity := Vector2(0.2, 0.2)

@export_group("Holding Objects")
@export var throw_force := 10.0
@export var follow_speed := 5.0
@export var follow_distance := 2.5
@export var max_distance_from_camera := 5.0
@export var drop_below_player := false
@export var ground_ray: RayCast3D ## Only needed if drop_below_player is true

var move_dir := Vector3.ZERO
var held_object: RigidBody3D

@onready var camera: Camera3D = $Camera3D
@onready var interact_ray: RayCast3D = $Camera3D/InteractRay


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(_delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	move_dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


func _physics_process(delta: float) -> void:
	handle_holding_objects()

	if not is_on_floor():
		velocity.y -= gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = jump_force

	velocity.x = lerp(velocity.x, move_dir.x * move_speed, acceleration * delta)
	velocity.z = lerp(velocity.z, move_dir.z * move_speed, acceleration * delta)
	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity.x * 0.01)
		camera.rotate_x(-event.relative.y * mouse_sensitivity.y * 0.01)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))


func pick_up(body: Node) -> void:
	if body is RigidBody3D:
		held_object = body


func drop_held_object() -> void:
	held_object = null


func throw_held_object() -> void:
	var obj := held_object
	drop_held_object()
	obj.apply_central_impulse(-camera.global_basis.z * throw_force)


func handle_holding_objects() -> void:
	if Input.is_action_just_pressed("throw") and held_object != null:
		throw_held_object()

	if Input.is_action_just_pressed("interact"):
		if held_object != null:
			drop_held_object()
		elif interact_ray.is_colliding():
			pick_up(interact_ray.get_collider())

	if held_object == null:
		return

	# Pull the held object towards a point in front of the camera.
	var target_pos := camera.global_position + camera.global_basis * Vector3(0, 0, -follow_distance)
	held_object.linear_velocity = (target_pos - held_object.global_position) * follow_speed

	if held_object.global_position.distance_to(camera.global_position) > max_distance_from_camera:
		drop_held_object()
	elif drop_below_player and ground_ray and ground_ray.get_collider() == held_object:
		drop_held_object()
