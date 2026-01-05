extends Node2D

@onready
var player: CharacterBody2D = $".."
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
			var b = attack_stats.bullet.instantiate()
			b.velocity = player.velocity + Vector2(attack_stats.shot_speed, 0).rotated(global_rotation+randf_range(-attack_stats.shot_spread, attack_stats.shot_spread))
			b.damage = attack_stats.shot_damage
			b.ttl = attack_stats.shot_range
			get_tree().current_scene.add_child(b)
			b.global_position = global_position
