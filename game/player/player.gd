extends KinematicBody2D
class_name Player

var velocity := Vector2.ZERO

export(int) var JUMP_FORCE := -130
export(int) var JUMP_RELEASE_FORCE := -70
export(int) var MAX_SPEED := 50
export(int) var ACCELERATIION := 10
export(int) var FRICTION := 10
export(int) var GRAVITY := 20
export(int) var ADDITIONAL_FALL_GRAVITY := 1

onready var animatedSprite = $AnimatedSprite

func _ready() -> void:
	animatedSprite.frames = load("res://player/player-red-skin.tres")

func _physics_process(delta: float) -> void:
	apply_gravity()
	var input := Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")

	if input.x == 0:
		apply_friction()
		animatedSprite.animation = "idle"
	else:
		apply_acceleration(input.x)
		animatedSprite.animation = "run"
		if input.x > 0:
			animatedSprite.flip_h = false
		elif input.x < 0:
			animatedSprite.flip_h = true
			

	if is_on_floor():
		if Input.is_action_just_pressed("ui_select"):
			velocity.y = JUMP_FORCE
	else:
		animatedSprite.animation = "jump"
		if Input.is_action_just_released("ui_select") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y = JUMP_RELEASE_FORCE
			
		if velocity.y < 0:
			velocity.y += ADDITIONAL_FALL_GRAVITY
	
	var was_in_air = not is_on_floor()
	velocity = move_and_slide(velocity, Vector2.UP)
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		animatedSprite.animation = "run"
		animatedSprite.frame = 1

func apply_gravity():
	velocity.y += GRAVITY
	velocity.y = min(velocity.y, 500)
	
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)
	
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATIION)
