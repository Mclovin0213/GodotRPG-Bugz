extends CanvasLayer

const HEART_ROW_SIZE = 8
const HEART_OFFSET = 16

func _ready():
	lives_check()

func _process(delta):
	$CoinText.text = String(Global.coin_number)
	$KeyNum.text = String(Global.keys)
	
	for heart in $PlayerLives.get_children():
		var index = heart.get_index()
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x,y)
		
		var last_heart = floor(Global.player_lives)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (Global.player_lives - last_heart) * 4
		if index < last_heart:
			heart.frame = 4
			
func lives_check():
	for i in Global.player_lives:
		var new_heart = Sprite.new()
		new_heart.texture = $PlayerLives.texture
		new_heart.hframes = $PlayerLives.hframes
		$PlayerLives.add_child(new_heart)

func reload_scene():
	queue_free()
