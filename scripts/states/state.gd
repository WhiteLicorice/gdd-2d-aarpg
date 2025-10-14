## 	Abstract class for all States.
class_name State extends Node

## Static reference to a Player object.
static var player: Player

## Fires when the State runs for the first time.
func enter() -> void:
	return

## Fires when the State terminates.
func exit() -> void:
	return

## Runs per frame inside _process.
func process(_delta: float) -> State:
	return null

## Runs per frame inside _physics_process.
func physics_process(_delta: float) -> State:
	return null

## Runs whenever an input event occurs.	
func take_input(_event: InputEvent) -> State:
	return null
