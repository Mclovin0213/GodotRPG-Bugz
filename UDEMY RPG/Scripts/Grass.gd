extends Area2D

onready var grass = preload("res://Prefabs/Effects/GrassEffect.tscn")
onready var coin = preload("res://Prefabs/Items/Coin.tscn")

func _on_Grass_area_entered(area):
	if area.is_in_group("Sword"):
		var grassFX = grass.instance()
		get_parent().add_child(grassFX)
		grassFX.global_position = global_position
		loot_generator()
		queue_free()

func loot_generator():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var loot_number = rng.randi_range(0, 5)
	
	if loot_number >= 3:
		coin_instance()
	else:
		null

func coin_instance():
	var coinLoot = coin.instance()
	get_parent().add_child(coinLoot)
	coinLoot.global_position = global_position
