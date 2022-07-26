extends StaticBody2D

onready var house = get_node("/root/Main/House/Sprite")

func _on_PlayerDetector_body_entered(body):
	if body.name == "Player":
		house.self_modulate.a = 0.5


func _on_PlayerDetector_body_exited(body):
	if body.name == "Player":
		house.self_modulate.a = 1


func _on_Door_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Prefabs/Interiors/InteriourHouse1.tscn")


func _on_SpawnPoint_body_entered(body):
	if body.is_in_group("Player"):
		Global.last_position = body.global_position
	
