extends RigidBody3D
class_name Cobe

@export_category("Setup")
@export var camera_parent: Node3D
@export var grounded_rays: Array[RayCast3D]

@export_category("Force Properties")
@export var walk_torque = 200
@export var run_torque = 400
@export var jump_impulse = 150

@export_category("Ray Properties")
@export var grounded_ray_length = 0.3

var camera: Camera3D
var should_run: bool = false
var move_input: Vector2 = Vector2.ZERO

var jump_delay: float = 0.1
var current_jump_time: float

func _ready() -> void:
	var children = camera_parent.get_children(true)
	for child in children:
		if child is Camera3D:
			camera = child

func _process(delta: float) -> void:
	move_input = Input.get_vector("move_left", "move_right", "move_backward", "move_forward")
	if current_jump_time > 0:
		current_jump_time -= delta

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		if is_grounded() and current_jump_time <= 0:
			jump()
	if Input.is_action_pressed("run"):
		should_run = true
	else:
		should_run = false

func _physics_process(_delta: float) -> void:
	is_grounded()
	move(move_input,should_run)

func move(input: Vector2, run: bool):
	var forceDir = Vector3(input.x, 0, -input.y).normalized()
	var relativeDir = forceDir.rotated(Vector3.UP, camera.global_rotation.y + deg_to_rad(90))
	#DebugDraw3D.draw_arrow(global_position, global_position + relativeDir * 4, Color.RED, 0.2, false)
	var torque = 0
	if run:
		torque = run_torque
	else:
		torque = walk_torque
	apply_torque(relativeDir * torque)

func jump():
	var jumpDir = Vector3.UP
	apply_impulse(jumpDir * jump_impulse)
	current_jump_time = jump_delay
	
func is_grounded() -> bool:
	var grounded = false
	for ray in grounded_rays:
		var global_target = ray.global_position + Vector3.DOWN * grounded_ray_length
		ray.target_position = ray.to_local(global_target)
		#DebugDraw3D.draw_arrow(ray.global_position, global_target, Color.RED, 0.2, false, 0)
		if ray.is_colliding():
			grounded = true
	return grounded


func Respawn(_position: Vector3, _rotation: Vector3):
	global_position = _position
	global_rotation = _rotation
	
	
