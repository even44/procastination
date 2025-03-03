extends Node3D


@export var bouncy_boost: float = 400

@export var vel_limit: float = 45

@onready var ball: RigidBody3D = $RigidBody3D



func _on_ball_body_entered(_body:Node):
	var vel = ball.linear_velocity
	if vel.length() < 60:
		vel = vel.normalized()
		ball.apply_impulse(vel * bouncy_boost)
	
