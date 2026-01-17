extends Node2D

@onready
var player: RigidBody2D = $".."
@onready
var attack_stats: PlayerAttackStats = $"../PlayerAttackStats"
var last_shot: float = 0

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		shoot()

func shoot():
	if Time.get_ticks_msec()-last_shot < float(1000.0/attack_stats.fire_rate):
		return
	last_shot = Time.get_ticks_msec()
	if attack_stats.is_beam:
		pass
	else:
		for a in range(attack_stats.shot_count):
			var b := attack_stats.bullet.instantiate()
			b.velocity = Vector2(attack_stats.shot_speed, 0).rotated(global_rotation+randf_range(-attack_stats.shot_spread, attack_stats.shot_spread))
			var dot = player.linear_velocity.normalized().dot(b.velocity.normalized())
			if dot > 0:
				b.velocity += player.linear_velocity*dot
			else :
				b.velocity += player.linear_velocity*-dot*0.5
			b.damage = attack_stats.shot_damage
			b.ttl = attack_stats.shot_range
			get_tree().current_scene.add_child(b)
			b.global_position = screen_wrap(global_position)
			b.collision_layer = 1
			b.collision_mask = 2

func screen_wrap(pos: Vector2) -> Vector2:
		return Vector2(
			wrapf(pos.x, Utils.camera_rect.position.x, Utils.camera_rect.end.x),
			wrapf(pos.y, Utils.camera_rect.position.y, Utils.camera_rect.end.y)
		)
