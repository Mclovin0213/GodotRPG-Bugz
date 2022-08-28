extends Node2D

export var rotation_speed = 0.3

func _physics_process(delta):
	rotate(rotation_speed)
