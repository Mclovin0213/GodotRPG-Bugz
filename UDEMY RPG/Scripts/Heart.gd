extends Node2D

var active = false
var item_bought = false


func _process(delta):
	$B_button.visible = active

func _input(event):
	if get_node_or_null("DialogNode") == null:
		if Input.is_action_just_pressed("ui_dialog") && active:
			get_tree().paused = true
			var dialog = Dialogic.start("Heart")
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			Dialogic.set_variable("coin", Global.coin_number)
			dialog.connect("timeline_end", self, "unpause")
			dialog.connect("dialogic_signal", self, "heart_effect")
			add_child(dialog)

func heart_effect(string):
	match string:
		"heart1":
			Global.player_lives = 10
			get_parent().reset_gui()
			item_bought = true
			queue_free()

func unpause(timeline_name):
	get_tree().paused = false
	if item_bought:
		Global.coin_number -= 15

func _on_PlayerDetector_body_entered(body):
	if body.name == "Player":
		active = true

func _on_PlayerDetector_body_exited(body):
	if body.name == "Player":
		active = false
