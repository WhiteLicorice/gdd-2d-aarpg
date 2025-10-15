## Orchestrates a Player through its States.
class_name PlayerStateMachine extends Node

var states: Array[State]
var previous_state: State
var current_state: State

func _ready() -> void:
	## Stops all activity until we explicitly start the state machine.
	process_mode = Node.PROCESS_MODE_DISABLED

func _process(delta: float) -> void:
	change_state(current_state.process(delta))

func _physics_process(delta: float) -> void:
	change_state(current_state.physics_process(delta))

func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.take_input(event))

## Attempts to change to a new State.
## If so, runs the new State's enter method and the old State's exit method.
## Otherwise, does nothing.
func change_state(new_state: State) -> void:
	if (new_state == null || new_state == current_state):
		return
	if (current_state):
		current_state.exit()
	previous_state = current_state
	current_state = new_state
	current_state.enter()

## Fetches all States attached to some Player object
## and sets the top-most state to be the initial state.
func initialize_states(player: Player) -> void:
	states = []
	for c in get_children():
		if (c is State):
			states.append(c)
	
	if (states.size() > 0):
		states[0].player = player
		change_state(states[0])
		## Inherits the process mode of its parent.
		process_mode = Node.PROCESS_MODE_INHERIT
