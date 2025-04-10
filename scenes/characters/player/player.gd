extends CharacterBody2D

@export var move_speed := 320.0
@export var acceleration := 10.0

var input_vector := Vector2.ZERO


func get_input_vector() -> Vector2:
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return input_vector
