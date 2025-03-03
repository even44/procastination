extends Node

#Level Stuff
@onready var level_holder = $"../LevelHolder"
@onready var ui_holder = $"../UI"

@export var level_system_scene: PackedScene = preload("res://game_systems/level_system.tscn")
var level_system: LevelSystem

var player_spawner: PlayerSpawner

var timer_system_scene: PackedScene = preload("res://game_systems/timer_system.tscn")
var timer_system: TimerSystem


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

	timer_system = timer_system_scene.instantiate()
	timer_system.ui_holder = ui_holder

	
	# Connect signals
	level_system.respawn_signal.connect(_on_level_respawn_signal)

func start_game():
	player_spawner.spawn_player_and_camera(Vector3.ZERO, Vector3.ZERO)
	level_system.load_level(0)
	timer_system.add_timer()
	timer_system.show_timer()
	timer_system.start_timer()

func game_loop():
	while true:
		if player_spawner.player.global_position.y < -10:
			level_system.restart_level()
			timer_system.stop_timer()
			timer_system.start_timer()
		await get_tree().create_timer(1).timeout

func exit():
	pass


func _on_level_respawn_signal(_position: Vector3, _rotation: Vector3):
	player_spawner.respawn_player_and_camera(_position, _rotation)
