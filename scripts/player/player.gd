class_name Player extends CharacterBody2D

const CARDINALITIES: Array[Vector2] = [Vector2.RIGHT,
										Vector2.DOWN,
										Vector2.LEFT,
										Vector2.UP,]
var move_speed: float = 25_000.0
var direction: Vector2 = Vector2.ZERO
var cardinality: Vector2 = Vector2.DOWN

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var player_state_machine = $PlayerStateMachine

signal direction_changed(new_direction: Vector2)

func update_animation(state: String) -> bool:
	animation_player.play(state + '_' + cardinality_to_string())
	return true

func update_direction() -> bool:
	if (direction == Vector2.ZERO):
		return false
	
	var direction_idx: int = int(round((direction + cardinality * 0.1).angle() / TAU * CARDINALITIES.size()))
	var new_direction: Vector2 = CARDINALITIES[direction_idx]

	if (new_direction == cardinality):
		return false
		
	cardinality = new_direction
	sprite_2d.scale.x = -1 if (cardinality.x < 0) else 1
	
	direction_changed.emit(cardinality)
		
	return true
		
func cardinality_to_string() -> String:
	if (cardinality == Vector2.DOWN):
		return 'down'
	elif (cardinality == Vector2.UP):
		return 'up'
	else:
		return 'side'

func _ready() -> void:
	player_state_machine.initialize_states(self)

func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis('left', 'right'),
		Input.get_axis('up', 'down')
	).normalized()
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
