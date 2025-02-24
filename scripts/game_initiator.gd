extends Node

@onready var level_holder = $"../LevelHolder"
@export var level_system_resource = preload("res://game_systems/level_system.tscn")
var level_system: LevelSystem


func _init() -> void:
	level_system = level_system_resource.instantiate()

func _ready() -> void:
	level_system.load_level(level_holder, 0)
