extends RigidBody3D

@onready var ray: RayCast3D = $"RayCast3D" 

@export_category("Setup")
@export var camera_parent: Node3D
@export var grounded_rays: Array[RayCast3D]

@export_category("Force Properties")
@export var walkTorque = 200
@export var runTorque = 300
@export var jumpImpulse = 100

var camera: Camera3D
var should_run: bool = false
var move_input: Vector2 = Vector2.ZERO

func _ready() -> void:
	var children = camera_parent.get_children(true)
	for child in children:
		if child is Camera3D:
			camera = child

func _process(delta: float) -> void:
	move_input = Input.get_vector("move_left", "move_right", "move_backward", "move_forward")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		if is_grounded() and get_contact_count() > 0:
			jump()
	if Input.is_action_pressed("run"):
		should_run = true
	else:
		should_run = false

func _physics_process(delta: float) -> void:
	move(move_input,should_run, delta)
	is_grounded()

func move(input: Vector2, run: bool, delta: float):
	var forceDir = Vector3(input.x, 0, -input.y).normalized()
	var relativeDir = forceDir.rotated(Vector3.UP, camera.global_rotation.y + deg_to_rad(90))
	#DebugDraw3D.draw_arrow(global_position, global_position + relativeDir * 4, Color.RED, 0.2, false)
	var torque = 0
	if should_run:
		torque = runTorque
	else:
		torque = walkTorque
	apply_torque(relativeDir * torque)

func jump():
	var jumpDir = Vector3.UP
	apply_impulse(jumpDir * jumpImpulse)
	
func is_grounded() -> bool:
	for ray in grounded_rays:
		var global_target = ray.global_position + Vector3.DOWN * 0.2
		ray.target_position = ray.to_local(global_target)
		ray.force_raycast_update()
		#DebugDraw3D.draw_arrow(ray.global_position, ray.global_position + ray.target_position, Color.RED, 0.1)
		if ray.is_colliding():
			return true
	return false
		
	
	
