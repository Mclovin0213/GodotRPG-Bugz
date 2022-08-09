extends Node2D

var active = false

func _input(event):
	if get_node_or_null("DialogNode") == null:
		if active:
			get_tree().paused = true
			var dialog = Dialogic.start("Skull")
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect("timeline_end", self, "unpause")
			dialog.connect("dialogic_signal", self, "skull_effect")
			add_child(dialog)

func skull_effect(argument):
	if argument == "yes":
		Global.skull_item = 1
		print("fire")

func unpause(timeline_name):
	get_tree().paused = false

func _on_PlayerDetector_body_entered(body):
	if body.name == "Player":
		active = true
