extends StaticBody2D

export(int) var speed = 1
export var length = Vector2()
export(int) var tween_mode = 1

func _ready():
	move()
	
func move():
	$Tween.interpolate_property(
		self,
		"position",
		global_position,
		global_position + length,
		speed,
		tween_mode,
		Tween.EASE_IN_OUT
	)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	length *= -1
	move()
