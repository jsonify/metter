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
	

#func set_random_direction() -> int:
#	pass
	
	
func set_direction_right():
	pass
	
	
func set_direction_left():
	pass


func update_direction():
	pass
	
	
func _physics_process(delta: float) -> void:
	pass
	

func apply_gravity(delta):
	pass
