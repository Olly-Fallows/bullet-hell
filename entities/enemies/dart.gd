extends RigidBody2D

@export
var speed: float = 100
@export
var acceleration: float = 1

var charging: bool = false
var target_pos: Vector2
var target_vel: Vector2 = Vector2()
var wrapping: bool = false

@onready
var player: Player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	$Health.dead.connect(queue_free)
	$Hitbox.hit.connect(func(_box):
		queue_free())

func _physics_process(delta: float) -> void:
	if player == null or not player.is_node_ready():
		return
	if charging:
		target_vel = (target_pos-global_position).normalized()*speed*1.5
		linear_velocity = linear_velocity.lerp(target_vel, acceleration*2*delta)
		if (target_pos-global_position).length() < linear_velocity.length():
			charging = false
	else:
		var diff = (player.global_position-global_position)
		if (diff.length() > 50 and diff.length() < 100) or randi_range(0, 75) == 0:
			target_pos = player.global_position
			charging = true
		else:
			var ang = diff.normalized().angle()
			linear_velocity = linear_velocity.lerp(Vector2(0.5,0.5).rotated(ang)*speed, acceleration*delta)
	look_at(global_position + linear_velocity)
	# Wrapping
	if wrapping:
		global_position.x = wrapf(global_position.x, Utils.camera_rect.position.x, Utils.camera_rect.end.x)
		global_position.y = wrapf(global_position.y, Utils.camera_rect.position.y, Utils.camera_rect.end.y)
	else:
		if global_position.x < Utils.camera_rect.end.x-32:
			if global_position.y < Utils.camera_rect.end.y-32:
				if global_position.x > Utils.camera_rect.position.x+32:
					if global_position.y > Utils.camera_rect.position.y+32:
						wrapping = true
						$Dart.mirroring = true
