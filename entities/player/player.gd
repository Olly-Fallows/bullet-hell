extends RigidBody2D
class_name Player

@onready
var body_stats: PlayerBodyStats = $PlayerBodyStats
@onready
var attack_stats: PlayerAttackStats = $PlayerAttackStats

var xp: int
var level: int

func _ready() -> void:
	body_stats.dead.connect(func():
		queue_free())

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("backward", "forward", "strafe_left", "strafe_right")
	var turn = Input.get_axis("left", "right")
	# Turn
	if turn:
		rotate(body_stats.turn_speed * turn * delta)
	# Move
	if input_dir:
		var forward = input_dir.rotated(rotation) * body_stats.speed
		linear_velocity = linear_velocity.lerp(forward, body_stats.acceloration * delta)
	# Wrapping
	global_position.x = wrapf(global_position.x, Utils.camera_rect.position.x, Utils.camera_rect.end.x)
	global_position.y = wrapf(global_position.y, Utils.camera_rect.position.y, Utils.camera_rect.end.y)
