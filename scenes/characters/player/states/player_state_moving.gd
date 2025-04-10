extends State


func physics_process(delta: float) -> void:
	var input = state_owner.get_input_vector()

	if input.length() == 0.0:
		state_machine.transition_to(PlayerConstants.STATES.IDLE)
		return

	if input.length_squared() > 1.0:
		input = input.normalized()

	state_owner.velocity = state_owner.velocity.lerp(
		input * state_owner.move_speed,
		state_owner.acceleration * delta
	)

	state_owner.move_and_slide()
