class_name Player extends CharacterBody2D

var move_speed: float = 25_000.0
var direction: Vector2 = Vector2.ZERO
var cardinality: Vector2 = Vector2.DOWN
var state: String = 'idle'

@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

func _play_animation() -> bool:
	animation_player.play(state + '_' + cardinality_to_string())
	return true

func _set_direction() -> bool:
	var new_direction: Vector2 = direction
	if (new_direction == Vector2.ZERO):
		return false
	
	if (direction.y == 0):
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif (direction.x == 0):
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN
		
	if (new_direction == cardinality):
		return false
		
	cardinality = new_direction
	sprite_2d.scale.x = -1 if (cardinality.x < 0) else 1
		
	return true
	
func _set_state() -> bool:
	var new_state: String = 'idle' if direction == Vector2.ZERO else 'walk'
	if (new_state == state):
		return false
	state = new_state	
	return true
	
func cardinality_to_string() -> String:
	if (cardinality == Vector2.DOWN):
		return 'down'
	elif (cardinality == Vector2.UP):
		return 'up'
	else:
		return 'side'

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	direction.x = Input.get_action_strength('right') - Input.get_action_strength('left')
	direction.y = Input.get_action_strength('down') - Input.get_action_strength('up')
	velocity = move_speed * direction * delta
	
	if _set_state() or _set_direction():
		_play_animation()

func _physics_process(delta: float) -> void:
	var has_collided: bool = move_and_slide()
