extends StaticBody2D

func _ready():
	$anim.play("Open")

func _on_PlayerEntered_player_entered():
	$anim.play("Close")

func _on_DefeatAllEnemy_enemy_defeated():
	$anim.play("Open")
