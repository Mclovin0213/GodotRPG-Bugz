extends Node2D

func _ready():
	$anim.play("Active")
	yield(get_node("anim"), "animation_finished")
	queue_free()
