extends YSort

onready var player = $Player

func _ready():
	if Global.last_position:
		player.global_position = Global.last_position
