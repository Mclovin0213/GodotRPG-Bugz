extends StaticBody2D

var active = false

func _process(delta):
	$dialogButton.visible = active
	
func _input(event):
	if Input.is_action_just_pressed("ui_dialog") && active:
		$anim.play("Trigger")
		yield(get_node("anim"), "animation_finished")
		$anim.play("Open")
		active = false

func _on_KeyDetector_body_entered(body):
	if body.name == "Player" && Global.keys >= 1:
		active = true
