class_name InputHelpers


static func get_movement_input_vector() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
