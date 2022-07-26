extends Area2D

signal switch_triggered

func _on_Switch_area_entered(area):
	if area.name == "Sword":
		emit_signal("switch_triggered")
		$anim.play("Triggered")
		yield(get_node("anim"), "animation_finished")
		$anim.play("Opened")
