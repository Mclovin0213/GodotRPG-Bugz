extends Camera2D

onready var player = get_node("../Player")

func _process(delta):
	position = player.global_position
	var x = floor(position.x / 512) * 512
	var y = floor(position.y / 300) * 300
	global_position = Vector2(x, y)
