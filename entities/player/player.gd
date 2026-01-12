extends Wrapping
class_name Player

@onready
var body_stats: PlayerBodyStats = $PlayerBodyStats
@onready
var attack_stats: PlayerAttackStats = $PlayerAttackStats

@onready
var thrusters: Array[GPUParticles2D] = [
	$GPUParticles2D, $GPUParticles2D2
]

var xp: int
var level: int

func _ready() -> void:
	wrapping = true
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
		for t in thrusters:
			t.emitting = true
		var forward = input_dir.rotated(rotation) * body_stats.speed
		linear_velocity = linear_velocity.lerp(forward, body_stats.acceloration * delta)
	else:
		for t in thrusters:
			t.emitting = false
	# Wrapping
	super.do_wrapping()
