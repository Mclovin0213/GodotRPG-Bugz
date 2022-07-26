extends StaticBody2D

onready var house = get_node("/root/Main/House2/Sprite")

func _on_PlayerDetector_body_entered(body):
	if body.name == "Player":
		house.self_modulate.a = 0.5


func _on_PlayerDetector_body_exited(body):
	if body.name == "Player":
		house.self_modulate.a = 1
