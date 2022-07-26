extends Area2D

func _on_Key_body_entered(body):
	if body.name == "Player":
		Global.keys += 1
		$audio.play()
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free()
