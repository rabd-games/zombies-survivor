extends Node
class_name StateMachine

@export var states := {}
@export var initial_state := ""

var _state_instances := {}
var _current_state: State


func _normalize_states() -> void:
	var normalized := {}

	for stateName in states.keys():
		var upperName: String = stateName.to_upper()
		var script: Script = states[stateName]
		var instance: State = script.new()

		instance.name = upperName
		normalized[upperName] = instance

	_state_instances = normalized


func _initial_validations() -> bool:
	if _state_instances.is_empty():
		push_error("StateMachine: 'states' dictionary is required and cannot be empty!")
		return false

	if initial_state.strip_edges() == "":
		push_error("StateMachine: 'initial_state' must be set.")
		return false

	elif not GDHelpers.has_ignore_case(_state_instances, initial_state):
		push_error("StateMachine: 'initial_state' '%s' not found in 'states'." % initial_state)
		return false

	return true


func transition_to(state_name: String, msg := {}) -> void:
	var key := state_name.to_upper()

	if _current_state:
		_current_state.exit()

	_current_state = _state_instances[key]
	_current_state.enter(msg)


func _ready():
	_normalize_states()
	if not _initial_validations(): return

	var parentNode := get_parent()

	for stateName in _state_instances.keys():
		var instance: State = _state_instances[stateName]
		instance.state_owner = parentNode
		instance.state_machine = self
		add_child(instance)

	transition_to(initial_state)


func register_state(stateName: String, state: State, parentNode: Node) -> void:
	var key := stateName.to_upper()
	state.name = key
	state.state_machine = self
	state.state_owner = parentNode
	add_child(state)
	_state_instances[key] = state


func _physics_process(delta: float) -> void:
	if _current_state:
		_current_state.physics_process(delta)


func _process(delta: float) -> void:
	if _current_state:
		_current_state.process(delta)
