extends Area2D
class_name Hitbox

signal hit(hurt: Hurtbox)

@export
var damage: float = 1
@export
var ttl: float = -1
@export
var percing: bool = false
@export
var velocity: Vector2 = Vector2()

@export
var look_at_dir: bool = false

@onready 
var screen_size = get_viewport_rect().size

func _ready() -> void:
	if ttl > 0:
		get_tree().create_timer(ttl, false, true).timeout.connect(queue_free)
	area_entered.connect(func(area: Area2D):
		if area is Hurtbox:
			hit.emit(area as Hurtbox)
			if not percing:
				queue_free())
	if look_at_dir:
		look_at(global_position+velocity)

func _physics_process(delta: float) -> void:
	global_position += velocity * delta
	if global_position.x < -64:
		queue_free()
	if global_position.y < -64:
		queue_free()
	if global_position.x > screen_size.x+64:
		queue_free()
	if global_position.y > screen_size.y+64:
		queue_free()
