extends KinematicBody2D

# Coordinate System
# +x = right
# -x = left
# +y = down
# -y = up

# Definitions
# Speed 			= a number/magnitude/value, without direction, distance/time,
# 				  i.e. ft/s, m/s
# Vector			= a number/magnitude/value, with a direction
# Velocity		= a number/magnitude/value, with a direction, a vector,
# 				  describes how position is changing, distance/time, ft/s, m/s
# Acceleration	= a number/magnitude/value, with a direction, a vector,
#				  describes how velocity is changing, distance/time^2, ft/s^2,
#				  m/s^2

class_name Enemy

export var GRAVITY := 1000.0 # acceleration
export var WALK_SPEED := 75 # speed

var velocity := Vector2.ZERO # (x, y)
var direction := "right" # enemy is facing which way?
var state

var rng := RandomNumberGenerator.new() # creates a new node of this class
var input_direction_x 

enum states {
	WALK,
	DEATH
}

func _ready() -> void:
	rng.randomize() # time based seed given to generator
	input_direction_x = 1
	state = states.WALK
	$MoveTimer.start()
	

func get_random_direction() -> int:
	var random_number := rng.randi_range(0, 1)
	return [-1, 1][random_number]
	
	
func set_direction_right():
	direction = "right"
	$AnimatedSprite.flip_h = false
	
	
func set_direction_left():
	direction = "left"
	$AnimatedSprite.flip_h = true
	

func update_direction(direction_x):
	if direction_x > 0:
		set_direction_right()
	elif direction_x < 0:
		set_direction_left()
	
	
func _physics_process(delta: float) -> void:
	match state:
		states.WALK:
			$AnimatedSprite.play("walk")
			update_direction(input_direction_x)
			velocity.x = WALK_SPEED * input_direction_x
			apply_gravity(delta)
			velocity = move_and_slide(velocity, Vector2.UP)
			
		states.DEATH:
			$AnimatedSprite.play("death")
			$CollisionShape2D.disabled = true
			yield($AnimatedSprite, "animation_finished")
			queue_free()
	

func apply_gravity(delta):
	velocity.y += GRAVITY * delta


func _on_MoveTimer_timeout() -> void:
	input_direction_x = get_random_direction()


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	
	if area.owner is Player:
		state = states.DEATH
