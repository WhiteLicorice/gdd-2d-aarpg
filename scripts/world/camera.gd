class_name Camera extends Camera2D

func _ready() -> void:
	GCameraController.bounds_changed.connect(update_bounds)
	
## Updates limit_left, limit_top, limit_right, limit_bottom
func update_bounds(top_left: Vector2i, bottom_right: Vector2i) -> void:
	#if top_left[0] == 0 and top_left[1] == 0:
		#return
	#if bottom_right[0] == 0 and bottom_right[1] == 0:
		#return
	limit_left = top_left[0]
	limit_top = top_left[1]
	limit_right = bottom_right[0]
	limit_bottom = bottom_right[1]
