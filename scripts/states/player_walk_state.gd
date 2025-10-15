## 	State for a walking Player.
class_name PlayerWalkState extends State

@export var move_speed: float = 25_000.0
@onready var idle_state: State = $"../IdleState"
@onready var attack_state: State = $"../AttackState"

## Fires when the State runs for the first time.
func enter() -> void:
	player.update_animation('walk')

## Fires when the State terminates.
func exit() -> void:
	return

## Runs per frame inside _process.
func process(delta: float) -> State:
	if (player.direction == Vector2.ZERO):
		return idle_state
	player.velocity = player.direction * move_speed * delta
	if player.update_direction():
		player.update_animation('walk')
	return null

## Runs per frame inside _physics_process.
func physics_process(_delta: float) -> State:
	return null

## Runs whenever an input event occurs.	
func take_input(event: InputEvent) -> State:
	if (event.is_action_pressed('attack')):
		return attack_state
	return null
