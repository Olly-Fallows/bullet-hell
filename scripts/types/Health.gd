extends Node2D
class_name Health

signal dead

@export
var max_health: float = 1
@onready
var health: float = max_health

func _ready() -> void:
	for c in get_children():
		if c is Hurtbox:
			c.hurt.connect(hurt)

func hurt(hitbox: Hitbox):
	health -= hitbox.damage
	if health <= 0:
		dead.emit()
