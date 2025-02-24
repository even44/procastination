extends Node
class_name LevelSystem

@export var levels: Array[PackedScene]



func load_level(parent_node: Node, level_idx: int):
	parent_node.add_child(levels[level_idx].instantiate())
