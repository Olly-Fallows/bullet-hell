extends RigidBody2D

var can_die: bool = false

func _ready() -> void:
	randomise_velocity.call_deferred()
	get_tree().create_timer(10).timeout.connect(func():
		can_die = true)
	$Health.dead.connect(die)

func die() -> void:
	Utils.spawn_explosion(global_position)
	queue_free()

func randomise_velocity():
	angular_velocity = randfn(-1.5,1.5)
	linear_velocity = randfn(30,40)*(((get_viewport_rect().size/2)+Vector2(randfn(-50, 50), randfn(-50, 50)))-global_position).normalized()
	
func _physics_process(_delta: float) -> void:
	if not can_die:
		return
	if global_position.x != wrapf(global_position.x, Utils.camera_rect.position.x, Utils.camera_rect.end.x):
		queue_free()
	if global_position.y != wrapf(global_position.y, Utils.camera_rect.position.y, Utils.camera_rect.end.y):
		queue_free()
