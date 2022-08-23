extends Node2D

signal enemy_defeated

func _process(delta):
	var enemy = get_child_count()
	if enemy <= 0:
		emit_signal("enemy_defeated")
