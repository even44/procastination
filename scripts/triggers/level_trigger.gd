extends Area3D
class_name LevelTrigger

signal trigger_restart_level
signal trigger_last_level
signal trigger_next_level

@export var mode: Mode

enum Mode {
	NextLevel,
	LastLevel,
	RestartLevel
}


func _on_body_entered(body: Node3D) -> void:
    if body.is_in_group("Player"):
        match mode:
            Mode.NextLevel:
                trigger_next_level.emit()
            Mode.LastLevel:
                trigger_last_level.emit()
            Mode.RestartLevel:
                trigger_restart_level.emit()
