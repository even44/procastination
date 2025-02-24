extends Node
class_name LevelSystem

signal respawn_signal(position: Vector3, rotation: Vector3)

var level_node: Node3D
var current_level: int = 0
var current_level_node: Node3D = null
var current_spawn_position: Vector3
var current_spawn_rotation: Vector3
@export var levels: Array[GameLevel]

func load_level(level_idx: int):
	if levels.size() > level_idx and level_idx >= 0:
		current_level_node = levels[level_idx].level_scene.instantiate()
		level_node.add_child(current_level_node)
		current_level = level_idx
		current_spawn_position = levels[current_level].spawn_position
		current_spawn_rotation = levels[current_level].spawn_rotation

		respawn_signal.emit(current_spawn_position, current_spawn_rotation)

	else:
		printerr("level index out of bounds")

func unload_current_level():
	current_level_node.queue_free()
	current_level_node = null

func next_level():
	unload_current_level()
	load_level(current_level + 1)

func restart_level():
	unload_current_level()
	load_level(current_level)
