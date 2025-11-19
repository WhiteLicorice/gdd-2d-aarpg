class_name Boundary extends StaticBody2D

@onready var top: CollisionShape2D = $Top
@onready var left: CollisionShape2D = $Left
@onready var bottom: CollisionShape2D = $Bottom
@onready var right: CollisionShape2D = $Right

func _ready() -> void:
	GBoundaryController.bounds_changed.connect(_set_boundaries)
	
func _set_boundaries(new_top: Vector2i, new_left: Vector2i, new_bot: Vector2i, new_right: Vector2i) -> void:
	print("New Positions: ", new_top, new_left, new_bot, new_right)
	top.position = new_top
	left.position = new_left
	bottom.position = new_bot
	right.position = new_right
