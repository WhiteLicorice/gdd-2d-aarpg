class_name _GCameraController extends Node

var curr_top_left: Vector2i
var curr_bottom_right: Vector2i

signal bounds_changed (top_left: Vector2i, bottom_right: Vector2i)

func change_bounds(top_left: Vector2i, bottom_right: Vector2i) -> void:
	curr_top_left = top_left
	curr_bottom_right = bottom_right
	bounds_changed.emit(top_left, bottom_right)
