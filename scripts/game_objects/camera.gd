extends Node3D

@export_category("Setup")
@export var target: Node3D

@export_category("Initials")
@export var offset: Vector3 = Vector3.ZERO
@onready var camera: Node3D = $"Camera3D"

@export var sensitivty = 10

var mouse_input: Vector2

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ESCAPE):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	global_position = lerp(global_position, target.global_position, 0.4)
	camera.position = offset
	
func _process(delta: float) -> void:
	rotate_cam(mouse_input.x * delta, mouse_input.y * delta)
	mouse_input = Vector2.ZERO

func rotate_cam(x, y):
	
	var rot = rotation_degrees
	rot.y = rot.y - x * sensitivty
	rot.x = clamp(rot.x - y * sensitivty, -89, 0)
	rot.z = 0
	rotation_degrees = rot
	

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_input += event.relative
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
