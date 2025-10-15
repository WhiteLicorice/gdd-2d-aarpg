## 	State for an idle Player.
class_name PlayerIdleState extends State

@onready var walk_state: State = $"../WalkState"
@onready var attack_state: State = $"../AttackState"

## Fires when the State runs for the first time.
func enter() -> void:
	player.update_animation('idle')

## Fires when the State terminates.
func exit() -> void:
	return

## Runs per frame inside _process.
func process(_delta: float) -> State:
	if (player.direction != Vector2.ZERO):
		return walk_state
	player.velocity = Vector2.ZERO
	return null

## Runs per frame inside _physics_process.
func physics_process(_delta: float) -> State:
	return null

## Runs whenever an input event occurs.	
func take_input(event: InputEvent) -> State:
	if (event.is_action_pressed('attack')):
		return attack_state
	return null
