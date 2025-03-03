extends Node
class_name TimerSystem

enum TimerState {
	STARTED,
	PAUSED,
	STOPPED
}


var top_center_timer_scene: PackedScene = preload("res://ui_scenes/timer/timer_top_center.tscn")
var timer_label: RichTextLabel
var current_timer: Control

var ui_holder: Control

var state = TimerState.STOPPED
var lastState = TimerState.STOPPED

var current_time: float = 0


func add_timer():
	ui_holder.add_child(self)
	current_timer = top_center_timer_scene.instantiate()
	ui_holder.add_child(current_timer)
	timer_label = current_timer.get_child(0)

func show_timer():
	current_timer.show()

func hide_timer():
	current_timer.hide()

func start_timer():
	print("Started timer")
	if lastState == TimerState.STOPPED:
		current_time = 0
	state = TimerState.STARTED

func stop_timer():
	state = TimerState.STOPPED

func pause_timer():
	state = TimerState.PAUSED

func _process(delta: float) -> void:
	
	match state:
		TimerState.STOPPED:
			pass
		TimerState.STARTED:
			current_time += delta
			timer_label.text = time_to_str(current_time)
		TimerState.PAUSED:
			pass
		_:
			pass

func time_to_str(time: float) -> String:
	var result_str: String = "%02d:%02d:%02d" % [int(time / 60),int(time) % 60,int(str(time).split(".")[1].left(2))]
	return result_str
