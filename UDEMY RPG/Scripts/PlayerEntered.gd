extends Area2D

signal player_entered

func _on_PlayerEntered_body_entered(body):
	emit_signal("player_entered")
	queue_free()
