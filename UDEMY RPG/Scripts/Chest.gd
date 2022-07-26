extends StaticBody2D

onready var keys = preload("res://Prefabs/Items/Key.tscn")

func _on_Area2D_area_entered(area):
	if area.is_in_group("Sword"):
		$anim.play("Open")
		$audio.play()
		var key = keys.instance()
		add_child(key)
		key.position = $spawnPoint.position
	
