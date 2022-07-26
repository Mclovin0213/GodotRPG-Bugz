extends StaticBody2D

func _on_Switch_switch_triggered():
	$anim.play("Open")
	$audio.play()
