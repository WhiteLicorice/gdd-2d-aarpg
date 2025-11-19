class_name Tilemap_ extends TileMapLayer

func _ready() -> void:
	var b: Array[Vector2i] = _get_bounds()
	GCameraController.change_bounds(b[0], b[1])

func _get_bounds() -> Array[Vector2i]:
	var top_left: Vector2i = get_used_rect().position * rendering_quadrant_size
	var bottom_right: Vector2i = get_used_rect().end * rendering_quadrant_size
	return [top_left, bottom_right]
