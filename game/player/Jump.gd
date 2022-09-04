extends PlayerState

func enter():
	player.velocity.y = player.JUMP_SPEED
	player.animation_state.travel("Fall")

func exit():
	pass
	
	
func physics_update(delta: float) -> void:
	
	if player.velocity.y > 0:
		state_machine.transition_to("Fall")
		return
	
	# allows left-right movement when falling
	var input_direction_x := (
		Input.get_action_strength("ui_right") 
		- Input.get_action_strength("ui_left")
	)
	
	player.update_direction(input_direction_x)
	player.velocity.x = player.WALK_SPEED * input_direction_x
	player.apply_gravity(delta)
	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	
	# handle collisions
	
	# handle other transitions
	if Input.is_action_just_pressed("dash") and player.has_dashes():
		state_machine.transition_to("Dash")
	
