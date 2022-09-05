extends PlayerState

func enter():
	player.NUM_DASHES -= 1
	player.is_dashing = true
	player.animation_state.travel("Dash")
#	SoundManager.dash_sound.play()

func exit():
	pass
	
	
func physics_update(delta: float) -> void:
	player.velocity.y = 0
	if player.direction == "right":
		player.velocity.x = player.DASH_SPEED
	else:
		player.velocity.x = -player.DASH_SPEED
	
	if !player.is_dashing:
		if player.is_on_floor():
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Fall")
		return
		
#	player.velocity = player.move_and_slide(player.velocity, Vector2.UP)
	player.velocity = player.move_and_slide_with_snap(player.velocity, 
													player.snap_vector, 
													Vector2.UP, 
													true, 
													4, 
													player.floor_max_angle, 
													false)
	
	# handle collisions
	if player.get_slide_count() > 0:
		for i in player.get_slide_count():
			var collision = player.get_slide_collision(i)
			var collider = collision.collider
			if collider is SpikeClub:
				state_machine.transition_to("Death")
				return

