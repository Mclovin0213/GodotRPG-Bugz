extends StaticBody2D

var active = false

func _process(delta):
	$B_button.visible = active

func _input(event):
	if get_node_or_null("DialogNode") == null:
		if Input.is_action_just_pressed("ui_dialog") && active:
			get_tree().paused = true
			var dialog = Dialogic.start("Dialog")
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect("dialogic_signal", self, "dialog_listener")
			dialog.connect("timeline_end", self, "unpause")
			add_child(dialog)

func unpause(timeline_name):
	get_tree().paused = false

func _on_PlayerDetector_body_entered(body):
	if body.name == "Player":
		active = true

func _on_PlayerDetector_body_exited(body):
	if body.name == "Player":
		active = false
