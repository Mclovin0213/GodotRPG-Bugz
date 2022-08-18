extends Node2D

onready var playerSpawn = preload("res://Prefabs/Player/Player.tscn")
onready var gui = preload("res://Prefabs/GUI.tscn")

func _ready():
	call_deferred("spawn_player")
	
func spawn_player():
	var player = playerSpawn.instance()
	get_parent().get_node("InteriorHouse3").add_child(player)
	player.global_position = $SpawnPoint.global_position
	
func reset_gui():
	$GUI.reload_scene()
	var new_gui = gui.instance()
	get_parent().get_node("InteriorHouse3").add_child(new_gui)

func _on_DoorHouse_body_entered(body):
	get_tree().change_scene("res://Prefabs/Levels/Main.tscn")
