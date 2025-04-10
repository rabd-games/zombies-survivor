extends State


func physics_process(delta: float) -> void:
	var input = state_owner.get_input_vector()

	if input.length() > 0.0:
		state_machine.transition_to(PlayerConstants.STATES.MOVING)

	var friction := 10.0
	state_owner.velocity = state_owner.velocity.lerp(Vector2.ZERO, friction * delta)
	state_owner.move_and_slide()
