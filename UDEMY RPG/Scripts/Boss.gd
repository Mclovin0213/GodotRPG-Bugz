extends KinematicBody2D

onready var deathFX = preload("res://Prefabs/Effects/deathEffect.tscn")
onready var playerDetector = $playerDetector

var velocity = Vector2.ZERO
var speed = 1000
var max_speed = 2000
var friction = 5
var player = null
var state = ATTACK
var attackB = false
var charge = false
var flip

enum {
	IDLE,
	ATTACK,
}

var knockback = Vector2.ZERO
var health = 20

func _physics_process(delta):
	flip_check()
	knockback = knockback.move_toward(Vector2.ZERO, 140 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			player_detect()
		ATTACK:
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * speed, max_speed * delta)
				if charge == true:
					velocity == velocity.bounce(direction)
					charge = false
			else:
				state = IDLE
				player = null
		
	$Sprite.flip_h = velocity.x < 0
	velocity = move_and_slide(velocity)
	

func player_detect():
	if player_detectable():
		state = ATTACK

func player_detectable():
	return player != null

func flash():
	$Sprite.material.set_shader_param("flash_modifier", 1)
	yield(get_tree().create_timer(0.2), "timeout")
	$Sprite.material.set_shader_param("flash_modifier", 0)
	
func flip_check():
	if velocity.x < 0:
		flip = false
	else:
		flip = true

func teleport_forward():
	charge = true

func attack_finish():
	attackB = false
	
func _on_hitbox_area_entered(area):
	if area.is_in_group("Sword"):
		flash()
		$audiohit.play()
		health -= Global.player_damage
		knockback = area.knockback_vector * 1000
		yield(get_tree().create_timer(0.7), "timeout")
		if health <= 0:
			var death = deathFX.instance()
			get_parent().add_child(death)
			death.global_position = $hitbox.global_position
			queue_free()

func _on_playerDetector_body_entered(body):
	if body.name == "Player" && attackB == false:
			player = body
	else:
			player = null

func _on_playerDetector_body_exited(body):
	if body.name == "Player":
		player = null
		velocity = Vector2.ZERO

func _on_attackDetector_body_entered(body):
	if body.name == "Player":
		attackB = true
		velocity = Vector2.ZERO
		$anim.play("Attack")

