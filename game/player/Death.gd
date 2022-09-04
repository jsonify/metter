extends PlayerState

func enter():
	player.animation_state.travel("Death")

func exit():
	pass
	
	
func physics_update(delta: float) -> void:
	pass
