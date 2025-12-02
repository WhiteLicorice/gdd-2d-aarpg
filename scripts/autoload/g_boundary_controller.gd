class_name GBoundaryController_ extends Node

var curr_top: Vector2i
var curr_left: Vector2i
var curr_bot: Vector2i
var curr_right: Vector2i

signal bounds_changed(top: Vector2i, left: Vector2i, bot: Vector2i, right: Vector2i)

## Changes the boundaries of the currently loaded map
## Assumes that boundaries are straight lines originating from the vectors.
## Assumes that boundaries are straight lines represented using world boundaries.
func change_bounds(new_top: Vector2i, new_left: Vector2i, new_bot: Vector2i, new_right: Vector2i) -> void:
	curr_top = new_top
	curr_left = new_left
	curr_bot = new_bot
	curr_right = new_right
	bounds_changed.emit(curr_top, curr_left, curr_bot, curr_right)
