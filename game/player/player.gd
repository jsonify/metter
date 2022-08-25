extends KinematicBody2D

var velocity = Vector2.ZERO

export (int) var GRAVITY := 4
export (int) var NORMAL_SPEED := 50
export (int) var JUMP_FORCE := -200

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		velocity.x = NORMAL_SPEED
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -NORMAL_SPEED
	else:
		velocity.x = 0
	
	if Input.is_action_just_pressed("ui_select"):
		velocity.y = JUMP_FORCE
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, Vector2.UP)
