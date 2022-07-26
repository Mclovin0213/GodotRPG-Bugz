extends KinematicBody2D

var state = MOVE

enum {
	MOVE,
	SWORD
}

onready var anim_tree = $AnimationTree
onready var anim_state = anim_tree.get("parameters/playback")
onready var sword_hitbox = $Sword
var sword_vector = Vector2.ZERO

var speed = 100
var velocity = Vector2.ZERO

var health = Global.player_lives

func _ready():
	sword_hitbox.knockback_vector = sword_vector

func _physics_process(delta):
	match state:
		MOVE:
			Move_state()
		SWORD:
			Sword_state()

func Move_state():
	var input_movement = Vector2.ZERO
	input_movement.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_movement.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_movement != Vector2.ZERO:
		sword_hitbox.knockback_vector = input_movement
		anim_tree.set("parameters/Idle/blend_position", input_movement)
		anim_tree.set("parameters/Walk/blend_position", input_movement)
		anim_tree.set("parameters/Sword/blend_position", input_movement)
		anim_state.travel("Walk")
		velocity += input_movement * speed
		velocity = velocity.clamped(speed)
	else:
		anim_state.travel("Idle")
		velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_sword"):
		state = SWORD
		$audio.play()
		
	move_and_slide(velocity)

func Sword_state():
	velocity = Vector2.ZERO
	anim_state.travel("Sword")

func Sword_finished():
	state = MOVE


func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		Global.player_lives -= 0.25
		if Global.player_lives <= 0:
			get_tree().reload_current_scene()
			Global.player_lives = 4
