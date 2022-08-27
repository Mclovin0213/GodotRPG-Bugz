extends Node2D

func _ready():
	$anim.play("Start")
	yield(get_node("anim"), "animation_finished")
	$anim.play("Main")
	
func _on_PlayButton_pressed():
	$anim.play("Fade-Out")
	$PlayButton/ButtonSound.play()
	yield(get_node("anim"), "animation_finished")
	get_tree().change_scene("res://Prefabs/Levels/Main.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()
