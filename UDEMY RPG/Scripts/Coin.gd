extends Area2D

func _on_Coin_body_entered(body):
	if body.name == "Player":
		Global.coin_number += 1
		$anim["playback_speed"] = 2
		$anim.play("Picked")
		$audio.play()
		yield(get_node("anim"), "animation_finished")
#		yield(get_tree().create_timer(1), "timeout")
		queue_free()
