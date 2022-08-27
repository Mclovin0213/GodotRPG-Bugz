extends Node2D

func _ready():
	$audio.play()
	
func change_scene():
	get_tree().change_scene("res://Prefabs/MenuScreen/TitleScreen.tscn")
