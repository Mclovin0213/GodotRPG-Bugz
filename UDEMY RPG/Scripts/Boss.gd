extends KinematicBody2D

onready var deathFX = preload("res://Prefabs/Effects/deathEffect.tscn")
onready var playerDetector = $playerDetector

var velocity = Vector2.ZERO
var speed = 120
var max_speed = 150
var friction = 5
var player = null

var state = ATTACK

enum {
	IDLE,
	ATTACK
}

var knockback = Vector2.ZERO
var health = 20

func _physics_process(delta):
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
	$Sprite.flip_h = velocity.x < 0

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
	if body.name == "Player":
		player = body

func _on_playerDetector_body_exited(body):
	if body.name == "Player":
		player = null
		velocity = Vector2.ZERO

func _on_attackDetector_body_entered(body):
	$anim.play("Attack")
