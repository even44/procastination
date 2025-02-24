extends Node
class_name PlayerSpawner

var spawn_node: Node3D

#Player Stuff
@export var player_scene: PackedScene = preload("res://object_scenes/player/cobe.tscn")
var player: Cobe

#Camera Stuff
@export var camera_scene: PackedScene = preload("res://object_scenes/player/camera.tscn")
var camera: ThridPersonCamera

func _init():
	# Create player systems
	player = player_scene.instantiate()
	camera = camera_scene.instantiate()

	player.camera_parent = camera
	camera.target = player

func spawn_player_and_camera(_position, _rotation):
	spawn_player(_position, _rotation)
	spawn_camera(_position, _rotation)

func spawn_player(_position: Vector3, _rotation: Vector3):
	spawn_node.add_child(player)
func spawn_camera(_position, _rotation):
	spawn_node.add_child(camera)

func respawn_player_and_camera(_position: Vector3, _rotation: Vector3):
	respawn_player(_position, _rotation)
	respawn_camera(_position, _rotation)

func respawn_player(_position: Vector3, _rotation: Vector3):
	player.global_position = _position
	player.global_rotation = _rotation
func respawn_camera(_position, _rotation):
	camera.global_position = _position
	camera.global_rotation = _rotation
