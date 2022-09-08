extends TileMap


func removeTile(num1, num2):
	self.set_cell(num1, num2, -1)

func _on_DefeatAllEnemy_enemy_defeated():
	removeTile(13,-20)
	removeTile(14,-20)
