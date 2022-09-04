extends PlayerState

func enter():
	player.is_attacking = true
	player.animation_state.travel("Attack")

func exit():
	pass
	
	
func physics_update(delta: float) -> void:
	if !player.is_attacking:
		state_machine.transition_to("Idle")
