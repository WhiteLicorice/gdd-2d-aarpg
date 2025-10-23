## 	State for an idle Player.
class_name PlayerAttackState extends State

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decceleration = 5
	
@onready var walk_state: State = $"../WalkState"
@onready var idle_state: State = $"../IdleState"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animation_player: AnimationPlayer = $"../../Sprite2D/AttackEffect/AnimationPlayer"
@onready var audio_stream_player: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"
@onready var hurt_box: HurtBox = %SwordHurtBox

var _is_attacking: bool = false

func end_attack(_new_animation_name: String) -> void:
	_is_attacking = false
	
## Fires when the State runs for the first time.
func enter() -> void:
	audio_stream_player.stream = attack_sound
	audio_stream_player.pitch_scale = randf_range(0.9, 1.1)
	audio_stream_player.play()
	player.update_animation('attack')
	attack_animation_player.play('attack_' + player.cardinality_to_string())
	animation_player.animation_finished.connect(end_attack)
	_is_attacking = true
	
	# Introduce a brief delay so the hurtbox only becomes active during
	# the apex of the sword's swing!
	await get_tree().create_timer(0.075).timeout
	
	hurt_box.monitoring = true
	
## Fires when the State terminates.
func exit() -> void:
	animation_player.animation_finished.disconnect(end_attack)
	_is_attacking = false
	hurt_box.monitoring = false
	
## Runs per frame inside _process.
func process(_delta: float) -> State:
	player.velocity = Vector2.ZERO
	if (not _is_attacking):
		if (player.direction == Vector2.ZERO):
			return idle_state
		else:
			return walk_state
	return null

## Runs per frame inside _physics_process.
func physics_process(_delta: float) -> State:
	return null

## Runs whenever an input event occurs.	
func take_input(_event: InputEvent) -> State:
	return null
	
