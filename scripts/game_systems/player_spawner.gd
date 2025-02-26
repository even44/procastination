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
	create_player_and_camera()

func create_player_and_camera():
	create_player()
	create_camera()
	player.camera_parent = camera
	camera.target = player
func create_player():
	player = player_scene.instantiate()
func create_camera():
	camera = camera_scene.instantiate()


func spawn_player_and_camera(_position, _rotation):
	spawn_player(_position, _rotation)
	spawn_camera(_position, _rotation)

func spawn_player(_position: Vector3, _rotation: Vector3):
	spawn_node.add_child(player)
	player.global_position = _position
	player.global_rotation = _rotation

func spawn_camera(_position, _rotation):
	spawn_node.add_child(camera)

func respawn_player_and_camera(_position: Vector3, _rotation: Vector3):
	player.queue_free()
	camera.queue_free()
	create_player_and_camera()
	spawn_player_and_camera(_position, _rotation)
