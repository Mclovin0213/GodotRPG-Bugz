extends Area2D

export(int) var id = 1

func _on_Stairs_body_entered(body):
	if body.name == "Player" && id == 1:
		get_tree().change_scene("res://Prefabs/Levels/Dungeon.tscn")
