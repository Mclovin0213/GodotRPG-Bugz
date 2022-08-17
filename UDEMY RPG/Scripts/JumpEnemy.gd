extends KinematicBody2D

onready var deathFX = preload("res://Prefabs/Effects/deathEffect.tscn")
onready var anim = $anim

export var speed = 100
export var max_speed = 120
export var jump_impulse = 10
export var jump_length = 30
export var friction = 5

var velocity = Vector2.ZERO
var state = WANDER
var curr_position = Vector2.ZERO


var knockback = Vector2.ZERO
var health = 2

var rng = RandomNumberGenerator.new()

enum {
	WANDER,
	ATTACK
}


func _ready():
	rng.randomize()

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 140 * delta)
	knockback = move_and_slide(knockback)

	match state:
		WANDER:
			pass
		ATTACK:
			pass

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
	pass # Replace with function body.

func _on_playerDetector_body_exited(body):
	pass # Replace with function body.

