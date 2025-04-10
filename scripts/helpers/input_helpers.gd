class_name InputHelpers


static func get_movement_input_vector() -> Vector2:
	var movementInputVector: Vector2

	movementInputVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movementInputVector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	return movementInputVector
