extends Node2D

onready var playerSpawn = preload("res://Prefabs/Player/Player.tscn")

func _ready():
	call_deferred("spawn_player")
	
func spawn_player():
	var player = playerSpawn.instance()
	get_parent().get_node("Dungeon").add_child(player)
	player.global_position = $PlayerSpawn.global_position

func _on_EntranceDoor_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Prefabs/Levels/Main.tscn")
