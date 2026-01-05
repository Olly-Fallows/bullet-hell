extends CharacterBody2D

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
@onready 
var screen_size = get_viewport_rect().size

func _ready() -> void:
	$Health.dead.connect(queue_free)

func _physics_process(delta: float) -> void:
	if charging:
		target_vel = (target_pos-global_position).normalized()*speed*1.5
		velocity = velocity.lerp(target_vel, acceleration*2*delta)
		if (target_pos-global_position).length() < velocity.length():
			charging = false
	else:
		var diff = (player.global_position-global_position)
		if (diff.length() > 50 and diff.length() < 100) or randi_range(0, 75) == 0:
			target_pos = player.global_position
			charging = true
		else:
			var ang = diff.normalized().angle()
			velocity = velocity.lerp(Vector2(0.5,0.5).rotated(ang)*speed, acceleration*delta)
	move_and_slide()
	look_at(global_position + velocity)
	# Wrapping
	if wrapping:
		global_position.x = wrapf(global_position.x, 0, screen_size.x)
		global_position.y = wrapf(global_position.y, 0, screen_size.y)
	else:
		if global_position.x < screen_size.x:
			if global_position.y < screen_size.y:
				if global_position.x > 0:
					if global_position.y > 0:
						wrapping = true
