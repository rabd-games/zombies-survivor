extends Node
class_name StateMachine

@export var states := {}
@export var initial_state := ""

var _state_instances := {}
var _current_state: State


func _ready():
	_normalize_states()
	_initial_validations()

	var owner := get_parent()

	for key in _state_instances.keys():
		var instance: State = _state_instances[key]
		instance.state_owner = owner
		instance.state_machine = self
		add_child(instance)

	transition_to(initial_state)


func _normalize_states() -> void:
	var normalized := {}

	for name in states.keys():
		var upper_name: String = name.to_upper()
		var script: Script = states[name]
		var instance: State = script.new()

		instance.name = upper_name
		normalized[upper_name] = instance

	_state_instances = normalized


func _initial_validations():
	if _state_instances.is_empty():
		push_error("StateMachine: 'states' dictionary is required and cannot be empty!")

	if initial_state.strip_edges() == "":
		push_error("StateMachine: 'initial_state' must be set.")

	elif not _state_instances.has(initial_state.to_upper()):
		push_error("StateMachine: 'initial_state' '%s' not found in 'states'." % initial_state)


func register_state(name: String, state: State, owner: Node) -> void:
	var key := name.to_upper()
	state.name = key
	state.state_machine = self
	state.state_owner = owner
	add_child(state)
	_state_instances[key] = state


func transition_to(state_name: String, msg := {}) -> void:
	var key := state_name.to_upper()

	if not _state_instances.has(key):
		push_error("StateMachine: State '%s' not found." % state_name)
		return

	if _current_state:
		_current_state.exit()

	_current_state = _state_instances[key]
	_current_state.enter(msg)


func _physics_process(delta: float) -> void:
	if _current_state:
		_current_state.physics_process(delta)


func _process(delta: float) -> void:
	if _current_state:
		_current_state.process(delta)
