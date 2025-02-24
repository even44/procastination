extends Node

#Level Stuff
@onready var level_holder = $"../LevelHolder"
@export var level_system_scene: PackedScene = preload("res://game_systems/level_system.tscn")
var level_system: LevelSystem

@export var player_spawner_scene: PackedScene
var player_spawner: PlayerSpawner



func _ready() -> void:
	setup()
	start_game()
	game_loop()
	exit()
	


func setup():
	# Create game systems
	level_system = level_system_scene.instantiate()
	level_system.level_node = level_holder

	player_spawner = PlayerSpawner.new()
	player_spawner.spawn_node = level_holder

	# Connect signals
	level_system.respawn_signal.connect(_on_level_respawn_signal)

func start_game():
	player_spawner.spawn_player_and_camera(Vector3.ZERO, Vector3.ZERO)
	level_system.load_level(0)

func game_loop():
	pass

func exit():
	pass


func _on_level_respawn_signal(_position: Vector3, _rotation: Vector3):
	player_spawner.respawn_player_and_camera(_position, _rotation)
