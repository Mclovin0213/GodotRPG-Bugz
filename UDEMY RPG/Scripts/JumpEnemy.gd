extends KinematicBody2D

onready var deathFX = preload("res://Prefabs/Effects/deathEffect.tscn")
onready var anim = $anim

var length = Vector2()
export(float) var speed = 1

var length_array = [
	Vector2(0,50), 
	Vector2(50,50), 
	Vector2(0,-50), 
	Vector2(-50,50), 
	Vector2(-50,0), 
	Vector2(-50,-50), 
	Vector2(50, -50), 
	Vector2(50,0)]
var knockback = Vector2.ZERO
var health = 2
var player = null

var state = IDLE
enum {
	IDLE,
	ATTACK
}

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 140 * delta)
	knockback = move_and_slide(knockback)
	
func length_check():
	if player != null:
		length = player_length()
	if player == null:
		length = rand_length()
		
func rand_length():
	var random_length = length_array[randi() % length_array.size()]
	return random_length

func player_length():
	var p_length = Vector2()
	var direction = (player.global_position - global_position)
	p_length = direction
	return p_length

func move():
	$Tween.interpolate_property(
		self,
		"position",
		global_position,
		global_position + length,
		speed,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
	)
	$Tween.start()

func stop_tween():
	$Tween.stop(self)

func _on_hitbox_area_entered(area):
	if area.is_in_group("Sword"):
		health -= Global.player_damage
		knockback = area.knockback_vector * 120
		yield(get_tree().create_timer(0.7), "timeout")
		if health <= 0:
			var death = deathFX.instance()
			get_parent().add_child(death)
			death.global_position = $hitbox.global_position
			queue_free()

func _on_playerDetector_body_entered(body):
	if body.name == "Player":
		player = body

func _on_playerDetector_body_exited(body):
	if body.name == "Player":
		player = null

func _on_Tween_tween_started(object, key):
	$audio.play()
