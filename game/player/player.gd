extends KinematicBody2D
class_name Player

onready var animation_state = $AnimationTree.get("parameters/playback")

export var GRAVITY := 1000
export var JUMP_SPEED := -300
export var WALK_SPEED := 75
export var DASH_SPEED := 300
export var NUM_DASHES := 1

# Handle slopes
var snap_length := 2
var snap_direction := Vector2.DOWN
var snap_vector := snap_direction * snap_length
var floor_max_angle := deg2rad(65)

var velocity := Vector2.ZERO
var direction := "right"
var is_attacking := false
var is_dashing := false

var state
enum states {
	IDLE,
	WALK,
	FALL,
	JUMP,
	ATTACK,
	DASH
}

func _ready() -> void:
	state = states.IDLE
	
func on_attack_finished():
	is_attacking = false
	
func on_dash_finished():
	is_dashing = false
	
# Replenish player dash count
func reset_dash_counter(value):
	NUM_DASHES = value

func has_dashes() -> bool:
	if NUM_DASHES > 0:
		return true
	return false
	
func restart_level():
	pass
		
func update_direction(input_direction_x) -> void:
	if input_direction_x > 0:
		set_direction_right()
	elif input_direction_x < 0:
		set_direction_left()

func apply_gravity(delta):
	velocity.y += GRAVITY * delta
	
func set_direction_right():
	direction = "right"
	$Sprite.flip_h = false
	$HitboxPosition.rotation_degrees = 0
	
func set_direction_left():
	direction = "left"
	$Sprite.flip_h = true
	$HitboxPosition.rotation_degrees = 180	
