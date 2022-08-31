extends StaticBody2D

func _on_DefeatAll_enemy_defeated():
	$anim.play("fade-out")
	yield(get_node("anim"), "animation_finished")
	queue_free()

