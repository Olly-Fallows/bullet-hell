extends CharacterBody2D
class_name Player

@onready
var body_stats: PlayerBodyStats = $PlayerBodyStats
@onready
var attack_stats: PlayerAttackStats = $PlayerAttackStats
@onready 
var screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("backward", "forward", "strafe_left", "strafe_right")
	var turn = Input.get_axis("left", "right")
	# Turn
	if turn:
		rotate(body_stats.turn_speed * turn * delta)
	# Move
	if input_dir:
		var forward = input_dir.rotated(rotation) * body_stats.speed
		velocity = velocity.lerp(forward, body_stats.acceloration * delta)
	move_and_slide()
	# Wrapping
	global_position.x = wrapf(global_position.x, 0, screen_size.x)
	global_position.y = wrapf(global_position.y, 0, screen_size.y)
