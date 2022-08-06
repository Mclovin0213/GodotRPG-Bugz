extends StaticBody2D

func _on_Door_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Prefabs/Interiors/InteriorHouse2.tscn")

func _on_SpawnPoint_body_entered(body):
	if body.is_in_group("Player"):
		Global.last_position = body.global_position
